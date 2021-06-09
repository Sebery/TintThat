//
//  EditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

final class EditorViewController: UIViewController {

    // MARK: - Properties
    private var collection = Collection(title: "", palettes: []) {
        didSet {
            titleLabel.text = collection.title
        }
    }
    
    private let colorCellID = "ColorCell"
    private let emptyCellID = "EmptyCell"
    private let headerCellID = "HeaderCell"
    private let colorCellHeight: CGFloat = 44.0
    private let headerCellHeight: CGFloat = 44.0
    
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
        
        // Test (remove this)
        collection = Collection(title: "Test", palettes: [Palette(colors: [.init(color: .red), .init(color: .blue), .init(color: .orange)]), Palette(colors: [.init(color: .red), .init(color: .blue), .init(color: .orange)]), Palette(colors: [.init(color: .red), .init(color: .blue), .init(color: .orange)])])
        
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
        collectionTB.backgroundColor = .primaryLight
        collectionTB.register(EditorHeaderView.self, forHeaderFooterViewReuseIdentifier: headerCellID)
    }
    
    func setupOptionsBtn() {
        let optionsBtn = UIButton(type: .custom)
        optionsBtn.frame = CGRect(x: 0.0, y: 0.0, width: 28, height: 28)
        optionsBtn.setImage(.optionsIcon, for: .normal)
        let highlightedImage = UIImage.optionsIcon.alpha(0.5)
        optionsBtn.setImage(highlightedImage, for: .highlighted)
        
        let rightBarItem = UIBarButtonItem(customView: optionsBtn)
        rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.rightBarButtonItem = rightBarItem
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if collection.isEmpty {
            return UITableView.automaticDimension
        }
        
        return colorCellHeight
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
        
        header?.titleLabel.text = collection.titleOfPalette(in: section)
        
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
            label.text = .empty
            label.textColor = .primaryDark
            label.font = .customHeadline
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: colorCellID, for: indexPath)
        cell.backgroundColor = collection.colorOfPalette(in: indexPath.section, forRow: indexPath.row).color
        
        return cell
    }
      
}
