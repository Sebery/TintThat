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
    
    struct Identifier {
        static let paletteCollectionListSegue = "PaletteCollectionListSegue"
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.paletteCollectionListSegue, let controller = segue.destination as? PaletteCollectionListViewController {
            controller.paletteCollectionOptionsVC = self
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Custom Methods
    private func saveCollection(collectionTitle: String, successTitle: String, failTitle: String) {
        var copy = paletteCollectionEditorVC?.paletteCollection
        copy?.title = collectionTitle
        
        if let paletteCollectionEditorVC = paletteCollectionEditorVC, let copy = copy, let data = PaletteCollectionFM.encode(paletteCollection: copy) {
            do {
                try data.write(to: PaletteCollectionFM.getPaletteColectionDirectory(fileName: paletteCollectionEditorVC.paletteCollection.id.uuidString), options: .atomic)
                
                paletteCollectionEditorVC.paletteCollection.title = collectionTitle
                paletteCollectionEditorVC.state = .editingCollection
                AlertController.showStateAlert(controller: self, title: "Saved", completion: { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                })
            } catch {
                AlertController.showStateAlert(controller: self, title: "Not saved, try again!", completion: { [weak self] in
                    self?.navigationController?.popToRootViewController(animated: true)
                })
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
            
            self?.saveCollection(collectionTitle: collectionTitle, successTitle: "Saved", failTitle: "Not saved, try again!")
        })
        
        titleAlert.addAction(cancelAction)
        titleAlert.addAction(saveAction)
        
        present(titleAlert, animated: true, completion: nil)
    }
    
    @IBAction func saveCollectionChangesAction() {
        if paletteCollectionEditorVC?.state == .editingCollection, let paletteCollectionEditorVC = paletteCollectionEditorVC {
            saveCollection(collectionTitle: paletteCollectionEditorVC.paletteCollection.title, successTitle: "Saved", failTitle: "Not saved, try again!")
        }
    }
    
    @IBAction func createNewCollectionAction() {
        var message = ""
        
        if paletteCollectionEditorVC?.state == .editingCollection {
            message = "You will lose unsaved changes"
        } else if paletteCollectionEditorVC?.state == .creatingCollection {
            message = "You will lose the unsaved collection"
        }
        
        let alert = UIAlertController(title: "Insert the title of your new collection", message: message, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            if let controller = self, let text = alert.textFields?.first?.text {
                controller.paletteCollectionEditorVC?.paletteCollection = PaletteCollection(title: text, palettes: [.init(section: 0, withColors: [.init(color: .red), .init(color: .cyan), .init(color: .brown)], withTitle: "My Palette")])
                controller.paletteCollectionEditorVC?.state = .editingCollection
                controller.saveCollection(collectionTitle: text, successTitle: "Created", failTitle: "Not created, try again!")
            }
        })
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPaletteToCollectionAction() {
        if let paletteCollectionEditorVC = paletteCollectionEditorVC {
            paletteCollectionEditorVC.addPaletteToCollection(palette: Palette(section: paletteCollectionEditorVC.paletteCollection.palettes.count, withColors: [.init(color: .black), .init(color: .cyan)], withTitle: "Added"))
            AlertController.showStateAlert(controller: self, title: "Added", completion: { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }

}
