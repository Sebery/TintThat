//
//  CreateViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

protocol CreateViewControllerDelegate: AnyObject {
    
    func createCollection(withName name: String)
    
    func editTitle(ofPalette section: Int, withName name: String)
    
}

final class CreateViewController: UIViewController {
    
    // MARK: - Properties
    private let maxChar = 14
    weak var delegate: CreateViewControllerDelegate?
    private var alertTitleProp = ""
    private var alertBtnTitleProp = ""
    private var textFieldTitleProp = ""
    var section = 0
    var alertState: alertState = .create
    
    var alertTitle: String {
        get { alertTitleProp }
        set { alertTitleProp = newValue }
    }
    
    var alertBtnTitle: String {
        get { alertBtnTitleProp }
        set { alertBtnTitleProp = newValue }
    }
    
    var textFieldTitle: String {
        get { textFieldTitleProp }
        set { textFieldTitleProp = newValue }
    }
    
    enum alertState {
        case create
        case edit
    }
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var titleContentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func buttonSelected(sender: UIButton) {
        sender.backgroundColor = .lightContext
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        sender.backgroundColor = .dark
    }
    
    @IBAction func create(sender: UIButton) {
        if let name = nameTextField.text, checkCollectionName(name: name) {
            dismiss(animated: true, completion: {
                if self.alertState == .create {
                    self.delegate?.createCollection(withName: name)
                } else if self.alertState == .edit {
                    self.delegate?.editTitle(ofPalette: self.section, withName: name)
                }
                
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
        mainContentView.backgroundColor = .light
        
        titleContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        titleContentView.backgroundColor = .light
        let titleLabel = titleContentView.subviews[0] as! UILabel
        titleLabel.textColor = .dark
        titleLabel.text = alertTitle
        titleLabel.font = .customHeadline
        
        nameTextField.backgroundColor = .light
        nameTextField.layer.cornerRadius = 8.0
        nameTextField.textColor = .dark
        nameTextField.font = .customBody
        nameTextField.attributedPlaceholder = NSAttributedString(string: String(maxChar) + .maxChar, attributes: [NSAttributedString.Key.foregroundColor: UIColor.fade])
        nameTextField.text = textFieldTitle
        
        createBtn.backgroundColor = .dark
        createBtn.setTitleColor(.light, for: .normal)
        createBtn.layer.cornerRadius = 8.0
        createBtn.setAttributedTitle(NSAttributedString(string: alertBtnTitle, attributes: [NSAttributedString.Key.font : UIFont.customBody]), for: .normal)
        
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
