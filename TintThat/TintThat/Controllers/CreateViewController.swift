//
//  CreateViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

protocol CreateViewControllerDelegate: AnyObject {
    
    func createCollection(withName name: String)
    
}

final class CreateViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: CreateViewControllerDelegate?
    private let maxChar = 14
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var titleContentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
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
        if let name = nameTextField.text, checkCollectionName(name: name) {
            dismiss(animated: true, completion: {
                self.delegate?.createCollection(withName: name)
            })
        }
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
        
        titleContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        titleContentView.backgroundColor = .primaryDark
        let titleLabel = titleContentView.subviews[0] as! UILabel
        titleLabel.textColor = .primaryLight
        titleLabel.text = .nameCollection
        titleLabel.font = .customHeadline
        
        nameTextField.backgroundColor = .primaryLight
        nameTextField.layer.cornerRadius = 8.0
        nameTextField.textColor = .primaryDark
        nameTextField.font = .customBody
        nameTextField.attributedPlaceholder = NSAttributedString(string: String(maxChar) + .maxChar, attributes: [NSAttributedString.Key.foregroundColor: UIColor.fade])
        
        createBtn.backgroundColor = .secondaryDark
        createBtn.setTitleColor(.secondaryLight, for: .normal)
        createBtn.layer.cornerRadius = 8.0
        createBtn.setAttributedTitle(NSAttributedString(string: .create, attributes: [NSAttributedString.Key.font : UIFont.customBody]), for: .normal)
        
        errorLabel.text = ""
        errorLabel.textColor = .error
        errorLabel.font = .customCaption
    }
    
    func checkCollectionName(name: String) -> Bool {
        if name.isEmpty {
            errorLabel.text = .emptyCharError
            return false
        } else if name.count > maxChar {
            errorLabel.text = .maxCharError + String(maxChar) + .maxCharErrorCause
            return false
        }
        
        return true
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
