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
    }
    
    // MARK: - Custom methods
    private func SetDefaultCollection() {
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
        palettes.append(Palette(section: 0, withColors: [.red, .green, .blue]))
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetDefaultCollection()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
        
        cell.backgroundColor = palettes[indexPath.section].colors[indexPath.row]
        
        return cell
    }

}
