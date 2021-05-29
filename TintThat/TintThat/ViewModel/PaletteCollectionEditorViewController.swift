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
    }
    
    struct Tag {
        static let colorCellBgView = 1000
    }
    
    struct Config {
        static let colorCellHeight: CGFloat = 44.0
        static let paletteHeaderHeight: CGFloat = 56.0
        static let paletteFooterHeight: CGFloat = 56.0
    }
    
    // MARK: - Custom methods
    private func SetDefaultCollection() {
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.paletteHeaderView)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.paletteFooterView) as! PaletteFooterView
        
        footer.deleteSectionAction = { [weak self] in
            self?.palettes.remove(at: section)
            self?.paletteCollectionTB.deleteSections([section], with: .automatic)
        }
        
        footer.addColorAction = { [weak self] in
            let row = self?.palettes[section].colors.count ?? 0
            self?.palettes[section].colors.insert(.cyan, at: row)
            self?.paletteCollectionTB.insertRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        
        
        
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
        cell.contentView.viewWithTag(Tag.colorCellBgView)?.backgroundColor = palettes[indexPath.section].colors[indexPath.row]
        
        return cell
    }

}
