//
//  LoadViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 10/06/21.
//

import UIKit

protocol LoadViewControllerDelegate: AnyObject {
    
    func loadCollection(collection: Collection)
    
}

final class LoadViewController: UIViewController {

    // MARK: - Properties
    private var collections = [Collection]()
    weak var delegate: LoadViewControllerDelegate?
    
    private let collectionCellID = "CollectionCell"
    private let emptyCellID = "EmptyCell"
    private let collectionCellHeight: CGFloat = 44.0
    private let collectionCellMargin: CGFloat = 16.0
    
    // MARK: - Outlets
    @IBOutlet weak var collectionsTB: UITableView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
}

// MARK: - Private
private extension LoadViewController {
    
    func initialSetup() {
        view.backgroundColor = .light
        
        // Get collections
        collections = CollectionFileManager.getDecodedCollections()
        
        // Setup collectionsTB
        collectionsTB.contentInset = UIEdgeInsets(top: -16.0, left: 0.0, bottom: -16.0, right: 0.0)
        collectionsTB.backgroundColor = .light
        
        // Setup cancel button
        setupCancelBtn()
    }
    
    func setupCancelBtn() {
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        cancelBtn.title = .cancel
        cancelBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline], for: .normal)
        cancelBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline, NSAttributedString.Key.foregroundColor : UIColor.lightContext], for: .highlighted)
        navigationItem.leftBarButtonItem = cancelBtn
    }
    
    // MARK: - Selectors
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension LoadViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if collections.isEmpty {
            return UITableView.automaticDimension
        }
        
        return collectionCellHeight + collectionCellMargin
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if collections.isEmpty {
            return
        }
        let contentView = tableView.cellForRow(at: indexPath)?.contentView.subviews[0]
        contentView?.backgroundColor = .lightContext
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.loadCollection(collection: collections[indexPath.row])
        
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDataSource
extension LoadViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collections.isEmpty {
            return 1
        }
        
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if collections.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCellID, for: indexPath)
            cell.backgroundColor = .light
            let emptyLabel = cell.contentView.subviews[0] as! UILabel
            emptyLabel.text = .emptyLoads
            emptyLabel.font = .customHeadline
            emptyLabel.textColor = .dark

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionCellID, for: indexPath)
        cell.contentView.backgroundColor = .light
        let contentView = cell.contentView.subviews[0]
        contentView.backgroundColor = .dark
        contentView.layer.cornerRadius = 8.0
        
        let titleLabel = contentView.subviews[0] as! UILabel
        titleLabel.text = collections[indexPath.row].title
        titleLabel.textColor = .light
        titleLabel.font = .customBody
        
        let marginView = cell.contentView.subviews[1]
        marginView.backgroundColor = .light
        
        return cell
    }
    
}
