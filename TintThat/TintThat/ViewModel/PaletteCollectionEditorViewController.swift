//
//  PaletteCollectionEditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 26/05/21.
//

import UIKit

class PaletteCollectionEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    private var palettes = [Palette]()
    
    struct Identifier {
        static let colorCell = "ColorCell"
        static let paletteHeaderView = "PaletteHeaderView"
        static let paletteFooterView = "PaletteFooterView"
        static let colorEditorVC = "ColorEditorVC"
        static let colorOptionsSegue = "ColorOptionsSegue"
    }
    
    struct Tag {
        static let colorCellBgView = 1000
    }
    
    struct Config {
        static let colorCellHeight: CGFloat = 44.0
        static let paletteHeaderHeight: CGFloat = 56.0
        static let paletteFooterHeight: CGFloat = 56.0
    }
    
    enum MoveColor: Int {
        case up = -1
        case down = 1
    }
    
    // MARK: - Custom methods
    private func SetDefaultCollection() {
        palettes.append(Palette(section: 0, withColors: [.init(color: .red), .init(color: .green), .init(color: .blue)]))
        palettes.append(Palette(section: 1, withColors: [.init(color: .red), .init(color: .green), .init(color: .blue)]))
        palettes.append(Palette(section: 2, withColors: [.init(color: .red), .init(color: .green), .init(color: .blue)]))
    }
    
    func showEditTitleAlert(forSection section: Int) {
        let editTitleAlert = UIAlertController(title: "Insert a new title for the palette", message: nil, preferredStyle: .alert)
        
        editTitleAlert.addTextField(configurationHandler: nil)
        
        let headerView = paletteCollectionTB.headerView(forSection: section) as? PaletteHeaderView
        
        if let textField = editTitleAlert.textFields?.first {
            textField.placeholder = headerView?.titleLabel.text ?? ""
        }
        
        let save = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let text = editTitleAlert.textFields?.first?.text {
                self?.palettes[section].title = text
                self?.paletteCollectionTB.reloadData()
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        editTitleAlert.addAction(save)
        editTitleAlert.addAction(cancel)
        
        present(editTitleAlert, animated: true, completion: nil)
    }
    
    func showDeletePaletteSheet(forSection section: Int) {
        let deleteSheet = UIAlertController(title: "Are you sure you want to delete this palette?", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            if let controller = self {
                controller.palettes.remove(at: section)
                controller.paletteCollectionTB.deleteSections([section], with: .automatic)
                controller.paletteCollectionTB.reloadSections(IndexSet(integersIn: 0..<controller.palettes.count), with: .automatic)
            }
        })
        
        deleteSheet.addAction(cancel)
        deleteSheet.addAction(delete)
        
        present(deleteSheet, animated: true, completion: nil)
    }
    
    func showAddColorEditor(forSection section: Int) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: Identifier.colorEditorVC) as? ColorEditorViewController {
            controller.paletteCollectionEditorVC = self
            controller.state = .addColor
            controller.colorPath = IndexPath(row: 0, section: section)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func addColorToPalette(forSection section: Int, andColor color: Color) {
        palettes[section].colors.insert(color, at: palettes[section].colors.count)
    }
    
    func getColorFromPalette(forSection section: Int, inRow row: Int) -> Color {
        return palettes[section].colors[row]
    }
    
    func setColorInPalette(forSection section: Int, inRow row: Int, withColor color: Color) {
        palettes[section].colors[row] = color
        paletteCollectionTB.reloadData()
    }
    
    func deleteColorInPalette(forSection section: Int, inRow row: Int) {
        palettes[section].colors.remove(at: row)
        paletteCollectionTB.deleteRows(at: [IndexPath(row: row, section: section)], with: .automatic)
    }
    
    func moveColorInPalette(forSection section: Int, inRow row: Int, to move: MoveColor) {
        if row >= palettes[section].colors.count - 1 && move == .down || row <= 0 && move == .up {
            return
        }
        
        palettes[section].colors.swapAt(row, row + move.rawValue)
        paletteCollectionTB.moveRow(at: IndexPath(row: row, section: section), to: IndexPath(row: row + move.rawValue, section: section))
    }
    
    // MARK: - Outlets
    @IBOutlet weak var paletteCollectionTB: UITableView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paletteCollectionTB.register(PaletteHeaderView.self, forHeaderFooterViewReuseIdentifier: Identifier.paletteHeaderView)
        paletteCollectionTB.register(PaletteFooterView.self, forHeaderFooterViewReuseIdentifier: Identifier.paletteFooterView)
        
        SetDefaultCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        paletteCollectionTB.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.colorOptionsSegue, let controller = (segue.destination as? UINavigationController)?.viewControllers.first as? ColorOptionsViewController, let cell = (sender as? UIButton)?.superview?.superview as? UITableViewCell, let indexPath = paletteCollectionTB.indexPath(for: cell) {
            controller.paletteCollectionEditorVC = self
            controller.colorPath = indexPath
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Config.colorCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Config.paletteHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Config.paletteFooterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.paletteHeaderView) as! PaletteHeaderView
        
        header.titleLabel?.text = palettes[section].title
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.paletteFooterView) as! PaletteFooterView
        
        footer.section = section
        footer.paletteCollectionEditorVC = self
        
        return footer
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return palettes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return palettes[section].colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.colorCell, for: indexPath)
        
        cell.backgroundColor = .lightGray
        cell.contentView.viewWithTag(Tag.colorCellBgView)?.backgroundColor = palettes[indexPath.section].colors[indexPath.row].color
        
        return cell
    }

}
