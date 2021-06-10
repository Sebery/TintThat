//
//  CreateViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

final class CreateViewController: UIViewController {

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func buttonSelected(sender: UIButton) {
        sender.backgroundColor = .secondaryAltLight
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
    }
    
    @IBAction func create(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - Private
private extension CreateViewController {
    
    func initialSetup() {
        // Setup main view
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissCreateVC))
        dismissTap.delegate = self
        view.addGestureRecognizer(dismissTap)
        
        //Setup main content view
        let mainContentView = view.subviews[0]
        mainContentView.layer.cornerRadius = 8.0
        mainContentView.backgroundColor = .secondaryLight
        
        let titleContentView = mainContentView.subviews[0]
        titleContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        titleContentView.backgroundColor = .primaryDark
        let titleLabel = titleContentView.subviews[0] as! UILabel
        titleLabel.textColor = .primaryLight
        titleLabel.text = .nameCollection
        titleLabel.font = .customHeadline
        
        let textField = mainContentView.subviews[1] as! UITextField
        textField.layer.cornerRadius = 8.0
        textField.textColor = .primaryDark
        textField.font = .customBody
        textField.attributedPlaceholder = NSAttributedString(string: .maxChar, attributes: [NSAttributedString.Key.foregroundColor: UIColor.fade])
        
        let createBtn = mainContentView.subviews[2] as! UIButton
        createBtn.backgroundColor = .secondaryDark
        createBtn.setTitleColor(.secondaryLight, for: .normal)
        createBtn.layer.cornerRadius = 8.0
        createBtn.setAttributedTitle(NSAttributedString(string: .create, attributes: [NSAttributedString.Key.font : UIFont.customBody]), for: .normal)
    }
    
    // MARK: - Selectors
    @objc func dismissCreateVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension CreateViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: view.subviews[0]) == true {
            return false
        }
        
        return true
    }
    
}
