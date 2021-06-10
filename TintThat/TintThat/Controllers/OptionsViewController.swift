//
//  OptionsViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 09/06/21.
//

import UIKit

final class OptionsViewController: UIViewController {

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func load(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func create(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPalette(sender: UIButton) {
        sender.backgroundColor = .secondaryDark
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        sender.backgroundColor = .secondaryAltLight
    }
    
    @IBAction func buttonUnselected(sender: UIButton) {
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
    }
    
}
