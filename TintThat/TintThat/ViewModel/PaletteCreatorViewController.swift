//
//  PaletteCreatorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 22/05/21.
//

import UIKit

class PaletteCreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var dataSource = [[Color]]()
    var currentColorOptionsState = ToColorOptionsState.changeColorInSection
    
    enum ToColorOptionsState {
        case changeColorInSection
        case addColorToSection
    }
    
    struct Config {
        static let rowHeight: CGFloat = 44.0
    }
    
    struct Identifiers {
        static let colorCell = "ColorCell"
        static let colorHeaderView = "ColorHeaderView"
        static let colorOptionsSegue = "ColorOptionsSegue"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var colorsTableView: UITableView!
    
    // MARK: - Actions
    @IBAction func editColors() {
        colorsTableView.isEditing.toggle()
    }
    
    @IBAction func addPalette() {
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
        
        colorsTableView.reloadData()
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        colorsTableView.register(ColorHeaderView.self, forHeaderFooterViewReuseIdentifier: Identifiers.colorHeaderView)
        
        // Add default colors
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.colorOptionsSegue, let controller = segue.destination as? ColorOptionsTableViewController {
            
            if currentColorOptionsState == .changeColorInSection {
                let cell = sender as! UITableViewCell
                
                let indexPath = colorsTableView.indexPath(for: cell)
                
                if let indexPath = indexPath {
                    let color = dataSource[indexPath.section][indexPath.row]
                    controller.currentColor = Color(r: color.r, g: color.g, b: color.b, indexPath: indexPath)
                }
            } else if currentColorOptionsState == .addColorToSection {
                if  let btn = sender as? UIButton, let headerView = btn.superview?.superview?.superview as? ColorHeaderView, let controller = segue.destination as? ColorOptionsTableViewController {
                    
                    controller.currentSection = headerView.currentSection
                }
            }

        }
    }
    
    // MARK: - Selectors
    @objc private func addColorToSection(sender: UIButton) {
        currentColorOptionsState = .addColorToSection
        performSegue(withIdentifier: Identifiers.colorOptionsSegue, sender: sender)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = colorsTableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.colorHeaderView) as! ColorHeaderView
        
        headerView.currentSection = section
        headerView.addColorButton.addTarget(self, action: #selector(addColorToSection(sender:)), for: .touchUpInside)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return Config.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Config.rowHeight
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.colorCell, for: indexPath)
        
        cell.backgroundColor = dataSource[indexPath.section][indexPath.row].rawColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataSource[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            dataSource[destinationIndexPath.section].swapAt(sourceIndexPath.row, destinationIndexPath.row)
        } else {
            dataSource[destinationIndexPath.section].insert(dataSource[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row)
            
            dataSource[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        }
        
    }
    
}
