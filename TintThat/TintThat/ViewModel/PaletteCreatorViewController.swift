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
    
    struct Identifiers {
        static let colorCell = "ColorCell"
        static let colorOptionsSegue = "ColorOptionsSegue"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var colorsTableView: UITableView!
    
    // MARK: - Actions
    @IBAction func EditColors() {
        colorsTableView.isEditing.toggle()
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add default colors
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
        dataSource.append([Color(r: 1.0, g: 0.0, b: 0.0), Color(r: 0.0, g: 1.0, b: 0.0), Color(r: 0.0, g: 0.0, b: 1.0)])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.colorOptionsSegue, let controller = segue.destination as? ColorOptionsTableViewController {
            
            let cell = sender as! UITableViewCell
            
            let indexPath = colorsTableView.indexPath(for: cell)
            
            if let indexPath = indexPath {
                let color = dataSource[indexPath.section][indexPath.row]
                controller.currentColor = Color(r: color.r, g: color.g, b: color.b, indexPath: indexPath)
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let field = PaletteHeaderTextField()
        field.text = "Palette \(section + 1)"
    
        return field
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
