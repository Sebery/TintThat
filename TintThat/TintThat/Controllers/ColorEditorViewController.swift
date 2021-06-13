//
//  ColorEditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 11/06/21.
//

import UIKit

protocol ColorEditorViewControllerDelegate: AnyObject {
    
    func showSearchColor()
    func showEditRGBA(forColorIn indexPath: IndexPath)
    
}

final class ColorEditorViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: ColorEditorViewControllerDelegate?
    var indexPath = IndexPath(row: 0, section: 0)

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func searchColor(sender: UIButton) {
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.showSearchColor()
        })
    }
    
    @IBAction func editRGBA(sender: UIButton) {
        sender.backgroundColor = .dark
        dismiss(animated: true, completion: {
            self.delegate?.showEditRGBA(forColorIn: self.indexPath)
        })
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        sender.backgroundColor = .lightContext
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
        sender.backgroundColor = .dark
    }

}

// MARK: - Private
private extension ColorEditorViewController {
    
    func initialSetup() {
        view.backgroundColor = .light
        view.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        // Setup main content view
        let mainContentView = view.subviews[0]
        mainContentView.backgroundColor = .light
        mainContentView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        let titleLabel = mainContentView.subviews[0].subviews[0] as! UILabel
        mainContentView.subviews[0].backgroundColor = .light
        titleLabel.text = .editColor
        titleLabel.backgroundColor = .light
        titleLabel.textColor = .dark
        titleLabel.font = .customHeadline
        
        let buttons = mainContentView.subviews[1].subviews as! [UIButton]
        let titleAttributes = [NSAttributedString.Key.font : UIFont.customBody]
        buttons[0].setAttributedTitle(NSAttributedString(string: .searchColor, attributes: titleAttributes), for: .normal)
        buttons[1].setAttributedTitle(NSAttributedString(string: .editRGBA, attributes: titleAttributes), for: .normal)
        
        for button in buttons {
            button.backgroundColor = .dark
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.light, for: .normal)
        }
    }
    
}
