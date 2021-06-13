//
//  EditRGBAViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 11/06/21.
//

import UIKit

protocol EditRGBAViewControllerDelegate: AnyObject {
    
    func saveColor(inPath path: IndexPath, withColor color: Color)
    
}

final class EditRGBAViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: EditRGBAViewControllerDelegate?
    private var currentColor = Color(color: .absence) {
        didSet {
            if isViewLoaded {
                view.subviews[0].subviews[0].backgroundColor = currentColor.color
                redSliderLabel?.text = currentColor.rTo255
                greenSliderLabel?.text = currentColor.gTo255
                blueSliderLabel?.text = currentColor.bTo255
                alphaSliderLabel?.text = currentColor.aTo255
            }
        }
    }
    var indexPath = IndexPath(row: 0, section: 0)
    
    private weak var redSliderLabel: UILabel?
    private weak var greenSliderLabel: UILabel?
    private weak var blueSliderLabel: UILabel?
    private weak var alphaSliderLabel: UILabel?
    
    var color: Color {
        get { currentColor }
        set { currentColor = newValue }
    }
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialsetup()
    }
    
    // MARK: - Actions
    @IBAction func rSliderChanged(sender: UISlider) {
        currentColor.r = CGFloat(sender.value)
    }
    
    @IBAction func gSliderChanged(sender: UISlider) {
        currentColor.g = CGFloat(sender.value)
    }
    
    @IBAction func bSliderChanged(sender: UISlider) {
        currentColor.b = CGFloat(sender.value)
    }
    
    @IBAction func aSliderChanged(sender: UISlider) {
        currentColor.a = CGFloat(sender.value)
    }

}

// MARK: - Private
private extension EditRGBAViewController {
    
    func initialsetup() {
        view.backgroundColor = .light
        
        // Setup color view
        view.subviews[0].backgroundColor = .light
        view.subviews[0].subviews[0].backgroundColor = currentColor.color
        view.subviews[0].subviews[0].layer.cornerRadius = 8.0
        
        // Setup RGBA view
        let stackViews = view.subviews[1].subviews
        let redLabel = stackViews[0].subviews[0] as! UILabel
        redLabel.text = .red
        redLabel.textColor = .dark
        redLabel.font = .customHeadline
        let greenLabel = stackViews[1].subviews[0] as! UILabel
        greenLabel.text = .green
        greenLabel.textColor = .dark
        greenLabel.font = .customHeadline
        let blueLabel = stackViews[2].subviews[0] as! UILabel
        blueLabel.text = .blue
        blueLabel.textColor = .dark
        blueLabel.font = .customHeadline
        let alphaLabel = stackViews[3].subviews[0] as! UILabel
        alphaLabel.text = .alpha
        alphaLabel.textColor = .dark
        alphaLabel.font = .customHeadline
        
        let redSliderLabel = stackViews[0].subviews[2] as! UILabel
        redSliderLabel.text = currentColor.rTo255
        redSliderLabel.textColor = .dark
        redSliderLabel.font = .customBody
        let greenSliderLabel = stackViews[1].subviews[2] as! UILabel
        greenSliderLabel.textColor = .dark
        greenSliderLabel.text = currentColor.gTo255
        greenSliderLabel.font = .customBody
        let blueSliderLabel = stackViews[2].subviews[2] as! UILabel
        blueSliderLabel.textColor = .dark
        blueSliderLabel.text = currentColor.bTo255
        blueSliderLabel.font = .customBody
        let alphaSliderLabel = stackViews[3].subviews[2] as! UILabel
        alphaSliderLabel.textColor = .dark
        alphaSliderLabel.text = currentColor.aTo255
        alphaSliderLabel.font = .customBody
        
        self.redSliderLabel = redSliderLabel
        self.greenSliderLabel = greenSliderLabel
        self.blueSliderLabel = blueSliderLabel
        self.alphaSliderLabel = alphaSliderLabel
        
        let redSlider = stackViews[0].subviews[1] as! UISlider
        redSlider.value = Float(currentColor.r)
        redSlider.tintColor = .lightContext
        redSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let greenSlider = stackViews[1].subviews[1] as! UISlider
        greenSlider.value = Float(currentColor.g)
        greenSlider.tintColor = .lightContext
        greenSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let blueSlider = stackViews[2].subviews[1] as! UISlider
        blueSlider.value = Float(currentColor.b)
        blueSlider.tintColor = .lightContext
        blueSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let alphaSlider = stackViews[3].subviews[1] as! UISlider
        alphaSlider.value = Float(currentColor.a)
        alphaSlider.tintColor = .lightContext
        alphaSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        
        // Setup navigation buttons
        setupCancelBtn()
        setupSaveBtn()
    }
    
    func setupCancelBtn() {
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        cancelBtn.title = .cancel
        cancelBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline], for: .normal)
        cancelBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline, NSAttributedString.Key.foregroundColor : UIColor.lightContext], for: .highlighted)
        navigationItem.leftBarButtonItem = cancelBtn
    }
    
    func setupSaveBtn() {
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        saveBtn.title = .save
        saveBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline], for: .normal)
        saveBtn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.customHeadline, NSAttributedString.Key.foregroundColor : UIColor.lightContext], for: .highlighted)
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    // MARK: - Selectors
    @objc func save() {
        delegate?.saveColor(inPath: indexPath, withColor: currentColor)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
}
