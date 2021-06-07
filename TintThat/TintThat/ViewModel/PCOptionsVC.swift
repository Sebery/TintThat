//
//  PCOptionsVC.swift
//  TintThat
//
//  Created by Sebastian Cruz on 05/06/21.
//

import UIKit

class PCOptionsVC: UIViewController {
    
    // MARK: - Properties
    private let animDuration = 0.2
    
    // MARK: - Outlets
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var fadeView: UIView!
    
    // MARK: - Actions
    @IBAction func load(sender: UIButton) {
        sender.backgroundColor = .primaryLight
        endAnimation()
    }
    
    @IBAction func create(sender: UIButton) {
        sender.backgroundColor = .primaryLight
        endAnimation()
    }
    
    @IBAction func addPalette(sender: UIButton) {
        sender.backgroundColor = .primaryLight
        endAnimation()
    }
    
    @IBAction func selected(sender: UIButton) {
        sender.backgroundColor = .primaryDark
    }
    
    @IBAction func unselected(sender: UIButton) {
        sender.backgroundColor = .primaryLight
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Avoid weird animation
        sheetView.center.y += sheetView.bounds.size.height
        sheetView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    // MARK: - Custom methods
    private func initialConfiguration() {
        // Add dismiss tap gesture
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissPCOptionsVC))
        fadeView.addGestureRecognizer(dismissTap)
        
        // Configure sheetView
        sheetView.backgroundColor = .secondaryLight
        sheetView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        
        // Configure sheetView title
        let sheetTitleLabelView = sheetView.subviews[0]
        sheetTitleLabelView.backgroundColor = .secondaryDark
        sheetTitleLabelView.customRoundCorners(withRadius: 8.0, forCorners: [.topLeft, .topRight])
        let sheetTitleLabel = sheetTitleLabelView.subviews[0] as! UILabel
        sheetTitleLabel.textColor = .secondaryLight
        sheetTitleLabel.font = .customRegular
        sheetTitleLabel.text = .pcOptions
        
        // Configure sheetView buttons
        let fontAttribute = [NSAttributedString.Key.font: UIFont.customMedium]
        let buttons = sheetView.subviews[1].subviews as! [UIButton]
        buttons[0].setAttributedTitle(NSAttributedString(string: .load, attributes: fontAttribute), for: .normal)
        buttons[1].setAttributedTitle(NSAttributedString(string: .create, attributes: fontAttribute), for: .normal)
        buttons[2].setAttributedTitle(NSAttributedString(string: .addPalette, attributes: fontAttribute), for: .normal)
        
        for button in buttons {
            button.backgroundColor = .primaryLight
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.secondaryLight, for: .normal)
        }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: animDuration, animations: {
            self.sheetView.center.y -= self.sheetView.bounds.size.height
            self.sheetView.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                UIView.animate(withDuration: self.animDuration, animations: {
                    self.fadeView.backgroundColor = .fade
                })
            }
        })
        
    }
    
    private func endAnimation() {
        UIView.animate(withDuration: animDuration, animations: {
            self.fadeView.backgroundColor = .abscence
        }, completion: { finished in
            if finished {
                UIView.animate(withDuration: self.animDuration, animations: {
                    self.sheetView.center.y += self.sheetView.bounds.size.height
                    self.sheetView.layoutIfNeeded()
                }, completion: { finished in
                    if finished {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            }
        })
    
    }
    
    // MARK: - Selectors
    @objc private func dismissPCOptionsVC() {
        endAnimation()
    }
    
}
