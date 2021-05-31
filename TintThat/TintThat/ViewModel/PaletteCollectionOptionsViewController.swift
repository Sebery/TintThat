//
//  PaletteCollectionOptionsViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 31/05/21.
//

import UIKit

class PaletteCollectionOptionsViewController: UITableViewController {

    // MARK: - Properties
    weak var paletteCollectionEditorVC: PaletteCollectionEditorViewController?
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Custom Methods
    private func showStateAlert(withTitle title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        present(alert, animated: true, completion: {
            alert.dismiss(animated: true, completion: { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            })
        })
    }
    
    // MARK: - Actions
    @IBAction func saveCollectionAction() {
        if let paletteCollectionEditorVC = paletteCollectionEditorVC, let data = PaletteCollectionFM.encode(paletteCollection: paletteCollectionEditorVC.paletteCollection) {
            do {
                try data.write(to: PaletteCollectionFM.getPaletteColectionDirectory(fileName: paletteCollectionEditorVC.paletteCollection.id.uuidString), options: .atomic)
                
                showStateAlert(withTitle: "Saved")
            } catch {
                showStateAlert(withTitle: "Not saved, try again!")
            }
            
        }
        
        
    }

}
