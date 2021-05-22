//
//  PaletteCreatorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 22/05/21.
//

import UIKit

class PaletteCreatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    private var dataSource = [[Color]]()
    
    struct Config {
        static let ColorCellHeight = 56
    }
    
    struct Identifiers {
        static let ColorCell = "ColorCell"
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
        dataSource.append([Color(rawColor: .red), Color(rawColor: .green), Color(rawColor: .blue)])
        dataSource.append([Color(rawColor: .red), Color(rawColor: .green), Color(rawColor: .blue)])
        dataSource.append([Color(rawColor: .red), Color(rawColor: .green), Color(rawColor: .blue)])
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let field = PaletteHeaderTextField()
        field.text = "Palette \(section + 1)"
    
        return field
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Row Selected")
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ColorCell, for: indexPath)
        
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
