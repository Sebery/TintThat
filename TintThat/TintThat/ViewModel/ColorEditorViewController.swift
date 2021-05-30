//
//  ColorEditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 28/05/21.
//

import UIKit

class ColorEditorViewController: UITableViewController {
    
    // MARK: - Properties
    var section: Int?
    weak var paletteCollectionEditorVC: PaletteCollectionEditorViewController?
    
    struct Identifier {
        static let rgbaEditorSegue = "RGBAEditorSegue"
    }

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Color Editor"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.rgbaEditorSegue, let section = section, let paletteCollectionEditorVC = paletteCollectionEditorVC, let destinationVC = segue.destination as? RGBAEditorViewController {
            destinationVC.section = section
            destinationVC.paletteCollectionEditorVC = paletteCollectionEditorVC
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
