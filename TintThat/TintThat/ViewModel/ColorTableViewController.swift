//
//  ColorTableViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 21/05/21.
//

import UIKit

class ColorTableViewController: UITableViewController {

    // MARK: - Properties
    private var colors = [Color]()
    
    private struct Identifiers {
        static let ColorCell = "ColorCell"
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add default color palette
        colors.append(.init(rawColor: .blue))
        colors.append(.init(rawColor: .cyan))
        colors.append(.init(rawColor: .brown))
        colors.append(.init(rawColor: .blue))
        colors.append(.init(rawColor: .cyan))
        colors.append(.init(rawColor: .brown))
        colors.append(.init(rawColor: .blue))
        colors.append(.init(rawColor: .cyan))
        colors.append(.init(rawColor: .brown))
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let field = PaletteHeaderTextField()

        field.text = "Palette \(section)"
        
        return field
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ColorCell, for: indexPath)

        cell.backgroundColor = colors[indexPath.row].rawColor

        return cell
    }

}
