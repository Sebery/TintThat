//
//  ColorEditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 28/05/21.
//

import UIKit

class ColorEditorViewController: UITableViewController {
    
    // MARK: - Properties
    var colorPath = IndexPath() // Row only necessary if the state is editColor
    var state: State = .addColor
    weak var paletteCollectionEditorVC: PaletteCollectionEditorViewController?
    
    enum State {
        case addColor
        case editColor
    }

    struct Identifier {
        static let rgbaEditorSegue = "RGBAEditorSegue"
    }

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Color Editor"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.rgbaEditorSegue, let paletteCollectionEditorVC = paletteCollectionEditorVC, let destinationVC = segue.destination as? RGBAEditorViewController {
            destinationVC.colorEditorVC = self
            destinationVC.paletteCollectionEditorVC = paletteCollectionEditorVC
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
