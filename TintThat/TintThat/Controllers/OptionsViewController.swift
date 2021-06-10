//
//  OptionsViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

protocol OptionsViewControllerDelegate: AnyObject {
    
    func showCreateCollection()
    func showLoadCollection()
    func addPaletteToCollection()
    
}

final class OptionsViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: OptionsViewControllerDelegate?
    var editorState: EditorViewController.EditorState = .notLoadedOrCreated
    
    private let addPaletteBtnTag = 1000

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func load(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: {
            self.delegate?.showLoadCollection()
        })
    }
    
    @IBAction func create(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: {
            self.delegate?.showCreateCollection()
        })
    }
    
    @IBAction func addPalette(sender: UIButton) {
        if editorState == .notLoadedOrCreated {
            return
        }
        
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: {
            self.delegate?.addPaletteToCollection()
        })
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        if sender.tag == addPaletteBtnTag, editorState == .notLoadedOrCreated {
            return
        }
        sender.backgroundColor = .secondaryAltLight
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        if sender.tag == addPaletteBtnTag, editorState == .notLoadedOrCreated {
            return
        }
        sender.backgroundColor = .secondaryDark
    }

}

// MARK: - Private
private extension OptionsViewController {
    
    func initialSetup() {
        view.backgroundColor = .secondaryLight
        view.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        // Setup main content view
        let mainContentView = view.subviews[0]
        mainContentView.backgroundColor = .secondaryLight
        mainContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        let titleLabel = mainContentView.subviews[0].subviews[0] as! UILabel
        mainContentView.subviews[0].backgroundColor = .primaryDark
        titleLabel.text = .options
        titleLabel.backgroundColor = .primaryDark
        titleLabel.textColor = .primaryLight
        titleLabel.font = .customHeadline
        
        let buttons = mainContentView.subviews[1].subviews as! [UIButton]
        let titleAttributes = [NSAttributedString.Key.font : UIFont.customBody]
        buttons[0].setAttributedTitle(NSAttributedString(string: .load, attributes: titleAttributes), for: .normal)
        buttons[1].setAttributedTitle(NSAttributedString(string: .create, attributes: titleAttributes), for: .normal)
        buttons[2].setAttributedTitle(NSAttributedString(string: .addPalette, attributes: titleAttributes), for: .normal)
        
        for button in buttons {
            button.backgroundColor = .secondaryDark
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.secondaryLight, for: .normal)
        }
        
        if editorState == .notLoadedOrCreated {
            buttons[2].backgroundColor = .primaryDark
        }
        
    }
    
}
