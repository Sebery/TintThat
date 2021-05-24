//
//  ColorOptionsTableViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 22/05/21.
//

import UIKit

class ColorOptionsTableViewController: UITableViewController {

    // MARK: - Properties
    var currentColor: Color?
    var currentSection: Int?
    
    struct Identifiers {
        static let colorPickerSegue = "ColorPickerSegue"
    }
    
    // MARK: - UIViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.colorPickerSegue, let controller = segue.destination as? ColorPickerViewController {
            
            if let color = currentColor {
                controller.currentColor = color
            } else if let section = currentSection {
                controller.currentSection = section
            }
  
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

}
