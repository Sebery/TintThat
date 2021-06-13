//
//  RemovePaletteViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 10/06/21.
//

import UIKit

protocol DeletePaletteViewControllerDelegate: AnyObject  {
    
    func deletePalette(inSection section: Int)
    
}

final class DeletePaletteViewController: UIViewController {

    // MARK: - Properties
    var section = 0
    weak var delegate: DeletePaletteViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var deleteLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    // MARK: - Actions
    @IBAction func deletePalette(sender: UIButton) {
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.deletePalette(inSection: self.section)
        })
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        sender.backgroundColor = .lightContext
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        sender.backgroundColor = .dark
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

}

// MARK: - Private
private extension DeletePaletteViewController {
    
    func initialSetup() {
        // Setup main view
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissDeletePaletteVC))
        dismissTap.delegate = self
        view.addGestureRecognizer(dismissTap)
        
        // Setup main content view
        let mainContentView = view.subviews[0]
        mainContentView.layer.cornerRadius = 8.0
        mainContentView.backgroundColor = .light
        
        // Setup deleteLabel
        deleteLabel.text = .deleteMessage
        deleteLabel.font = .customHeadline
        deleteLabel.textColor = .dark
        
        // Setup deleteBtn
        deleteBtn.setAttributedTitle(NSAttributedString(string: .delete, attributes: [NSAttributedString.Key.font : UIFont.customBody]), for: .normal)
        deleteBtn.backgroundColor = .dark
        deleteBtn.layer.cornerRadius = 8.0
        deleteBtn.setTitleColor(.light, for: .normal)
    }
    
    // MARK: - Selectors
    @objc func dismissDeletePaletteVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension DeletePaletteViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: view.subviews[0]) == true {
            return false
        }
        
        return true
    }
    
}
