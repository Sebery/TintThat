//
//  PaletteCollectionListViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 01/06/21.
//

import UIKit

class PaletteCollectionListViewController: UITableViewController {
    
    // MARK: - Properties
    private var paletteCollections = [PaletteCollection]()
    weak var paletteCollectionOptionsVC: PaletteCollectionOptionsViewController?
    
    struct Identifier {
        static let paletteCollectionCell = "PaletteCollectionCell"
    }
    
    struct Config {
        static let cellHeight = 44
    }
    
    struct Tag {
        static let cellTitle = 1000
    }
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        paletteCollections = PaletteCollectionFM.getDecodedCollections()
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Config.cellHeight)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var title = ""
        if let paletteCollectionEditorVC = paletteCollectionOptionsVC?.paletteCollectionEditorVC {
            if paletteCollectionEditorVC.state == .editingCollection {
                title = "Are you sure you want to load this collection?, you will lose unsaved changes"
            } else if paletteCollectionEditorVC.state == .creatingCollection {
                title = "Are you sure you want to load this collection?, you will lose the unsaved collection"
            }
        }
        
        AlertController.showImportantAlert(controller: self, title: title, leftActionTitle: "Cancel", rightActionTitle: "Load", rightAction:{ _ in
            AlertController.showStateAlert(controller: self, title: "Loaded", completion: { [weak self] in
                if let controller = self {
                    controller.paletteCollectionOptionsVC?.paletteCollectionEditorVC?.paletteCollection = controller.paletteCollections[indexPath.row]
                    controller.paletteCollectionOptionsVC?.paletteCollectionEditorVC?.state = .editingCollection
                    controller.navigationController?.popToRootViewController(animated: true)
                }
            })
        })

    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paletteCollections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.paletteCollectionCell, for: indexPath)
        
        let label = cell.viewWithTag(Tag.cellTitle) as! UILabel
        label.text = paletteCollections[indexPath.row].title
        
        return cell
    }

}
