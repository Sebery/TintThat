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
    
    // MARK: - Outlets
    @IBOutlet weak var saveAsBtn: UIButton!
    @IBOutlet weak var saveChangesBtn: UIButton!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if paletteCollectionEditorVC?.state == .editingCollection {
            saveAsBtn.backgroundColor = .lightGray
        } else if paletteCollectionEditorVC?.state == .creatingCollection {
            saveChangesBtn.backgroundColor = .lightGray
        }
    }
    
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
    
    private func saveCollection(collectionTitle: String) {
        var copy = paletteCollectionEditorVC?.paletteCollection
        copy?.title = collectionTitle
        
        if let paletteCollectionEditorVC = paletteCollectionEditorVC, let copy = copy, let data = PaletteCollectionFM.encode(paletteCollection: copy) {
            do {
                try data.write(to: PaletteCollectionFM.getPaletteColectionDirectory(fileName: paletteCollectionEditorVC.paletteCollection.id.uuidString), options: .atomic)
                
                paletteCollectionEditorVC.paletteCollection.title = collectionTitle
                paletteCollectionEditorVC.state = .editingCollection
                showStateAlert(withTitle: "Saved")
            } catch {
                showStateAlert(withTitle: "Not saved, try again!")
            }
            
        }
    }
    
    // MARK: - Actions
    @IBAction func saveAsCollectionAction() {
        if paletteCollectionEditorVC?.state == .editingCollection {
            return
        }
        
        let titleAlert = UIAlertController(title: "Insert the title of the new collection", message: nil, preferredStyle: .alert)
        
        titleAlert.addTextField(configurationHandler: nil)
        var collectionTitle = ""
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let text = titleAlert.textFields?.first?.text {
                collectionTitle = text
            }
            
            self?.saveCollection(collectionTitle: collectionTitle)
        })
        
        titleAlert.addAction(cancelAction)
        titleAlert.addAction(saveAction)
        
        present(titleAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveCollectionChangesAction() {
        if paletteCollectionEditorVC?.state == .editingCollection, let paletteCollectionEditorVC = paletteCollectionEditorVC {
            saveCollection(collectionTitle: paletteCollectionEditorVC.paletteCollection.title)
        }
    }

}
