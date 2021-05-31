//
//  ColorOptionsViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 30/05/21.
//

import UIKit

class ColorOptionsViewController: UITableViewController {
    
    // MARK: - Properties
    weak var paletteCollectionEditorVC: PaletteCollectionEditorViewController!
    var colorPath: IndexPath = IndexPath()
    
    // MARK: - Actions
    @IBAction func moveUp() {
        dismiss(animated: true, completion: { [weak self] in
            if let controller = self {
                controller.paletteCollectionEditorVC.moveColorInPalette(forSection: controller.colorPath.section, inRow: controller.colorPath.row, to: .up)
            }
        })
    }
    
    @IBAction func moveDown() {
        dismiss(animated: true, completion: { [weak self] in
            if let controller = self {
                controller.paletteCollectionEditorVC.moveColorInPalette(forSection: controller.colorPath.section, inRow: controller.colorPath.row, to: .down)
            }
        })
    }
    
    @IBAction func delete() {
        dismiss(animated: true, completion: { [weak self] in
            if let controller = self {
                controller.paletteCollectionEditorVC.deleteColorInPalette(forSection: controller.colorPath.section, inRow: controller.colorPath.row)
            }
        })
    }

}
