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
    func deleteCurrentCollection()
    
}

final class OptionsViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: OptionsViewControllerDelegate?
    var editorState: EditorViewController.EditorState = .notLoadedOrCreated
    
    private let addPaletteBtnTag = 1000
    private let deleteCollectionTag = 1001

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func load(sender: UIButton) {
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.showLoadCollection()
        })
    }
    
    @IBAction func create(sender: UIButton) {
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.showCreateCollection()
        })
    }
    
    @IBAction func delete(sender: UIButton) {
        if editorState == .notLoadedOrCreated {
            return
        }
        
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.deleteCurrentCollection()
        })
    }
    
    @IBAction func addPalette(sender: UIButton) {
        if editorState == .notLoadedOrCreated {
            return
        }
        
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.addPaletteToCollection()
        })
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        if (sender.tag == addPaletteBtnTag || sender.tag == deleteCollectionTag), editorState == .notLoadedOrCreated {
            return
        }
        sender.backgroundColor = .lightContext
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        if sender.tag == addPaletteBtnTag, editorState == .notLoadedOrCreated {
            return
        }
        sender.backgroundColor = .dark
    }

}

// MARK: - Private
private extension OptionsViewController {
    
    func initialSetup() {
        view.backgroundColor = .light
        view.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        // Setup main content view
        let mainContentView = view.subviews[0]
        mainContentView.backgroundColor = .light
        mainContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        let titleLabel = mainContentView.subviews[0].subviews[0] as! UILabel
        mainContentView.subviews[0].backgroundColor = .light
        titleLabel.text = .options
        titleLabel.backgroundColor = .light
        titleLabel.textColor = .dark
        titleLabel.font = .customHeadline
        
        let buttons = mainContentView.subviews[1].subviews as! [UIButton]
        let titleAttributes = [NSAttributedString.Key.font : UIFont.customBody]
        buttons[0].setAttributedTitle(NSAttributedString(string: .load, attributes: titleAttributes), for: .normal)
        buttons[1].setAttributedTitle(NSAttributedString(string: .create, attributes: titleAttributes), for: .normal)
        buttons[2].setAttributedTitle(NSAttributedString(string: .delete, attributes: titleAttributes), for: .normal)
        buttons[3].setAttributedTitle(NSAttributedString(string: .addPalette, attributes: titleAttributes), for: .normal)
        
        for button in buttons {
            button.backgroundColor = .dark
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.light, for: .normal)
        }
        
        if editorState == .notLoadedOrCreated {
            buttons[2].backgroundColor = .fade
            buttons[3].backgroundColor = .fade
        }
        
    }
    
}
