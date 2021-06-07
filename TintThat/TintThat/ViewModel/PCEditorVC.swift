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
    private var collectionTitle = "" {
        didSet {
            titleLabel.text = collectionTitle
        }
    }
    
    private let colorCellID = "ColorCell"
    private let emptyCellID = "EmptyCell"
    private let pcOptionsVCID = "PCOptionsVC"
    
    private let colorCellHeight: CGFloat = 44.0
    
    // MARK: - Outlets
    @IBOutlet weak var paletteCollectionTB: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
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
        
        // Configure title outlets
        titleView.backgroundColor = .secondaryLight
        titleLabel.backgroundColor = .secondaryLight
        titleLabel.font = .customHeader
        titleLabel.textColor = .secondaryDark
        collectionTitle = "My best colors"
        
        // Change main tab bar titles and images
        if let items = tabBarController?.tabBar.items {
            items[0].image = .editorIcon
            items[0].title = .editor
            items[1].title = .myPalettes
            items[1].image = .myPalettesIcon
            items[2].title = .settings
            items[2].image = .settingsIcon
        }
        
        // Add rightBarItem
        setPCOptionsBtn()
    }
    
    private func setPCOptionsBtn() {
        let optionsBtn = UIButton(type: .custom)
        optionsBtn.frame = CGRect(x: 0.0, y: 0.0, width: 32, height: 28)
        optionsBtn.setImage(.optionsIcon, for: .normal)
        let highlightedImage = UIImage.optionsIcon.alpha(0.5)
        optionsBtn.setImage(highlightedImage, for: .highlighted)
        
        optionsBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        optionsBtn.addTarget(self, action: #selector(showPCOptions), for: .touchUpInside)
        
        let rightBarItem = UIBarButtonItem(customView: optionsBtn)
        rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    // MARK: - Selectors
    @objc private func showPCOptions() {
        if let pcOptionsVC = storyboard?.instantiateViewController(withIdentifier: pcOptionsVCID) {
            pcOptionsVC.modalPresentationStyle = .overFullScreen
            pcOptionsVC.modalTransitionStyle = .coverVertical
            
            present(pcOptionsVC, animated: false, completion: nil)
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if paletteCollection.isEmpty {
            return UITableView.automaticDimension
        }
        
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
            cell.backgroundColor = .secondaryDark
            cell.layer.cornerRadius = 8.0
            
            let label = cell.contentView.subviews[0] as! UILabel
            label.font = .customMedium
            label.text = .noCollection
            label.textColor = .secondaryLight
            
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
