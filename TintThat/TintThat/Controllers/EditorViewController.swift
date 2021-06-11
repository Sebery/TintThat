//
//  EditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

final class EditorViewController: UIViewController {

    // MARK: - Properties
    private var state: EditorState = .notLoadedOrCreated
    
    private var collection = Collection(title: "", palettes: []) {
        didSet {
            state = .loadedOrCreated
            titleLabel.text = collection.title
            CollectionFileManager.saveCollection(collection: collection)
        }
    }
    
    private lazy var transitionManager = TransitionManager()
    
    private let colorCellID = "ColorCell"
    private let emptyCellID = "EmptyCell"
    private let headerCellID = "HeaderCell"
    private let footerCellID = "FooterCell"
    private let optionsVCID = "OptionsVC"
    private let createVCID = "CreateVC"
    private let loadVCID = "LoadVC"
    private let deletePaletteVCID = "DeletePaletteVC"
    private let colorCellHeight: CGFloat = 44.0
    private let headerCellHeight: CGFloat = 52.0
    private let footerViewHeight: CGFloat = 52.0
    private let sectionMarginHeight: CGFloat = 16.0
    
    enum EditorState {
        case notLoadedOrCreated
        case loadedOrCreated
    }
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionTB: UITableView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
}

// MARK: - Private
private extension EditorViewController {
    
    func initialSetup() {
        view.backgroundColor = .primaryLight
        
        // TODO: Load the last collection in editor
        
        // Setup main tab bar
        if let items = tabBarController?.tabBar.items {
            items[0].image = .editorIcon
            items[0].title = .editor
            items[1].title = .myPalettes
            items[1].image = .myPalettesIcon
            items[2].title = .settings
            items[2].image = .settingsIcon
        }
        
        // Setup titleLabel
        titleLabel.textColor = .primaryDark
        titleLabel.font = .customTitle
        titleLabel.backgroundColor = .secondaryLight
        
        // Setup optionsBtn
        setupOptionsBtn()
        
        // Setup collection table view
        collectionTB.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 0.0, right: 0.0)
        collectionTB.backgroundColor = .primaryLight
        collectionTB.register(EditorHeaderView.self, forHeaderFooterViewReuseIdentifier: headerCellID)
        collectionTB.register(EditorFooterView.self, forHeaderFooterViewReuseIdentifier: footerCellID)
    }
    
    func setupOptionsBtn() {
        let optionsBtn = UIButton()
        optionsBtn.frame = CGRect(x: 0.0, y: 0.0, width: 28, height: 28)
        optionsBtn.setImage(.optionsIcon, for: .normal)
        optionsBtn.setImage(.optionsIcon.alpha(0.5), for: .highlighted)
        optionsBtn.addTarget(self, action: #selector(showOptions), for: .touchUpInside)

        let rightBarItem = UIBarButtonItem(customView: optionsBtn)
        rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    // MARK: - Selectors
    @objc func showOptions() {
        if let optionsVC = storyboard?.instantiateViewController(withIdentifier: optionsVCID) as? OptionsViewController {
            optionsVC.modalPresentationStyle = .custom
            transitionManager.presentationType = .sheet(height: 208.0)
            optionsVC.transitioningDelegate = transitionManager
            optionsVC.delegate = self
            optionsVC.editorState = state
            present(optionsVC, animated: true, completion: nil)
        }
    }
    
    @objc func showDeletePalette(sender: UIButton) {
        if let deletePaletteVC = storyboard?.instantiateViewController(withIdentifier: deletePaletteVCID) as? DeletePaletteViewController {
            deletePaletteVC.modalPresentationStyle = .custom
            transitionManager.presentationType = .alert
            deletePaletteVC.transitioningDelegate = transitionManager
            deletePaletteVC.delegate = self
            if let editorFooterView = sender.superview?.superview?.superview as? EditorFooterView {
                deletePaletteVC.section = editorFooterView.section
            }
            present(deletePaletteVC, animated: true, completion: nil)
        }
    }
    
}

// MARK: - DeletePaletteViewControllerDelegate
extension EditorViewController: DeletePaletteViewControllerDelegate {
    
    func deletePalette(inSection section: Int) {

        
        collection.deletePalette(inSection: section)
        collectionTB.beginUpdates()
        collectionTB.deleteSections([section], with: .automatic)
        collectionTB.endUpdates()
        
        //print(collection.count)
        //collectionTB.reloadData()
//        collectionTB.deleteSections([section], with: .automatic)
//        collection.deletePalette(inSection: section)
//        UIView.animate(withDuration: 0.2, animations: {
//            self.collectionTB.deleteSections([section], with: .automatic)
//        }, completion: { finished in
//            if finished {
//
//                self.collection.deletePalette(inSection: section)
//                self.collectionTB.reloadData()
//            }
//        })
    }
    
}
 
// MARK: - OptionsViewControllerDelegate
extension EditorViewController: OptionsViewControllerDelegate {
    
    func showCreateCollection() {
        if let createVC = storyboard?.instantiateViewController(withIdentifier: createVCID) as? CreateViewController {
            createVC.modalPresentationStyle = .custom
            transitionManager.presentationType = .alert
            createVC.transitioningDelegate = transitionManager
            createVC.delegate = self
            present(createVC, animated: true, completion: nil)
        }
    }
    
    func showLoadCollection() {
        if let loadVC = storyboard?.instantiateViewController(withIdentifier: loadVCID) as? LoadViewController {
            loadVC.delegate = self
            navigationController?.pushViewController(loadVC, animated: true)
        }
    }
    
    func addPaletteToCollection() {
        if state == .loadedOrCreated {
            collection.addPalette(palette: Palette(colors: [.init(color: .secondaryAltLight), .init(color: .secondaryAltDark), .init(color: .secondaryAltLight)]))
            collectionTB.reloadData()
        }
        
    }
    
}

// MARK: - LoadViewControllerDelegate
extension EditorViewController: LoadViewControllerDelegate {
    
    func loadCollection(collection: Collection) {
        self.collection = collection
        collectionTB.reloadData()
    }
    
}

// MARK: - CreateViewControllerDelegate
extension EditorViewController: CreateViewControllerDelegate {
    
    func createCollection(withName name: String) {
        collection = Collection(title: name, palettes: [])
        collectionTB.reloadData()
    }
    
}

// MARK: - UITableViewDelegate
extension EditorViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if collection.isEmpty {
            return 1
        }
        
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if collection.isEmpty {
            return 0
        }
        
        return footerViewHeight + sectionMarginHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if collection.isEmpty {
            return UITableView.automaticDimension
        }
        
        return colorCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if collection.isEmpty {
            return nil
        }
        
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerCellID) as! EditorFooterView
        footer.section = section
        
        footer.mainContentView.deletePaletteBtn.addTarget(self, action: #selector(showDeletePalette(sender:)), for: .touchUpInside)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if collection.isEmpty {
            return 0
        }
        
        return headerCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if collection.isEmpty {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerCellID) as? EditorHeaderView
        
        header?.title = collection.titleOfPalette(in: section)
        
        return header
    }
    
}

// MARK: - UITableViewDataSource
extension EditorViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collection.isEmpty {
            return 1
        }
        
        return collection.numberOfColors(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if collection.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCellID, for: indexPath)
            cell.backgroundColor = .primaryLight
            let label = cell.contentView.subviews[0] as! UILabel
            if state == .notLoadedOrCreated {
                label.text = .notLoadedOrCreated
            } else if state == .loadedOrCreated {
                label.text = .loadedOrCreated
            }
            
            label.textColor = .primaryDark
            label.font = .customHeadline
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: colorCellID, for: indexPath)
        cell.contentView.backgroundColor = .primaryAltLight
        cell.contentView.subviews[0].backgroundColor = collection.colorOfPalette(in: indexPath.section, forRow: indexPath.row).color
        let colorBtn = cell.contentView.subviews[1] as! UIButton
        colorBtn.tintColor = .primaryAltDark
        colorBtn.setImage(.optionsIcon.alpha(0.5), for: .highlighted)
        
        return cell
    }
      
}

