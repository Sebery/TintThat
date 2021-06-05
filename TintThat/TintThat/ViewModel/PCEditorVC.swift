//
//  PCEditorVC.swift
//  TintThat
//
//  Created by Sebastian Cruz on 04/06/21.
//

import UIKit

class PCEditorVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    private var paletteCollection = PaletteCollection(title: "", palettes: [Palette]())
    
    private let colorCellID = "ColorCell"
    private let emptyCellID = "EmptyCell"
    
    private let colorCellHeight: CGFloat = 44.0
    
    // MARK: - Outlets
    @IBOutlet weak var paletteCollectionTB: UITableView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
    }
    
    // MARK: - Custom methods
    private func initialConfiguration() {
        // Set UI colors
        view.backgroundColor = .primaryLight
        paletteCollectionTB.backgroundColor = .primaryLight
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = .secondaryLight
        tabBarController?.tabBar.tintColor = .primaryDark
        tabBarController?.tabBar.unselectedItemTintColor = .secondaryDark
        
        // Hide border in main tab bar
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        
        // Change main tab bar titles and images
        if let items = tabBarController?.tabBar.items {
            items[0].image = .editorIcon
            items[0].title = .editor
            items[1].title = .myPalettes
            items[1].image = .myPalettesIcon
            items[2].title = .settings
            items[2].image = .settingsIcon
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return colorCellHeight
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if paletteCollection.isEmpty {
            return 1
        }
        
        return paletteCollection.numberOfColors(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if paletteCollection.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCellID, for: indexPath)
            cell.backgroundColor = .primaryDark
            
            let label = cell.contentView.subviews[0] as! UILabel
            label.font = .customMedium
            label.text = .empty
            label.textColor = .secondaryDark
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: colorCellID, for: indexPath)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if paletteCollection.isEmpty {
            return 1
        }
        
        return paletteCollection.count
    }
    
}
