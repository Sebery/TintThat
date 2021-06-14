//
//  EditRGBAViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 11/06/21.
//

import UIKit

protocol ColorEditorViewControllerDelegate: AnyObject {
    
    func saveColor(inPath path: IndexPath, withColor color: Color)
    
}

final class ColorEditorViewController: UIViewController {
    
    // MARK: Properties
    weak var delegate: ColorEditorViewControllerDelegate?
    private var currentColor: Color = .init(rgbColor: .absence) {
        didSet {
            if isViewLoaded {
                colorView.backgroundColor = getColorState()
            }
        }
    }
    var indexPath = IndexPath(row: 0, section: 0)
    var editorState: ColorOptionsViewController.EditorState = .RGB
    
    var color: Color {
        get { currentColor }
        set { currentColor = newValue }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var firstSliderLabel: UILabel!
    @IBOutlet weak var secondSliderLabel: UILabel!
    @IBOutlet weak var thirdSliderLabel: UILabel!
    @IBOutlet weak var opacitySliderLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    // MARK: - Actions
    @IBAction func firstSliderChangedAction(sender: UISlider) {
        if editorState == .RGB {
            currentColor.r = CGFloat(sender.value)
            firstSliderLabel.text = currentColor.rString
        } else if editorState == .HSB {
            currentColor.h = CGFloat(sender.value)
            firstSliderLabel.text = currentColor.hString
        }
    }
    
    @IBAction func secondSliderChangedAction(sender: UISlider) {
        if editorState == .RGB {
            currentColor.g = CGFloat(sender.value)
            secondSliderLabel.text = currentColor.gString
        } else if editorState == .HSB {
            currentColor.s = CGFloat(sender.value)
            secondSliderLabel.text = currentColor.sString
        }
    }
    
    @IBAction func thirdSliderChangedAction(sender: UISlider) {
        if editorState == .RGB {
            currentColor.b = CGFloat(sender.value)
            thirdSliderLabel.text = currentColor.bString
        } else if editorState == .HSB {
            currentColor.v = CGFloat(sender.value)
            thirdSliderLabel.text = currentColor.vString
        }
    }
    
    @IBAction func opacityChangedAction(sender: UISlider) {
        currentColor.opacity = CGFloat(sender.value)
        opacitySliderLabel.text = currentColor.opacityString
    }
}

// MARK: - Private
private extension ColorEditorViewController {
    
    func initialSetup() {
        view.backgroundColor = .light
        
        // Setup color view
        view.subviews[0].backgroundColor = .light
        colorView.backgroundColor = getColorState()
        view.subviews[0].subviews[0].layer.cornerRadius = 8.0
        
        // Setup color stack views
        let stackViews = view.subviews[1].subviews
        let firstLabel = stackViews[0].subviews[0] as! UILabel
        firstLabel.text = editorState == .RGB ? .red : .hue
        firstLabel.textColor = .dark
        firstLabel.font = .customHeadline
        let secondLabel = stackViews[1].subviews[0] as! UILabel
        secondLabel.text =  editorState == .RGB ? .green : .saturation
        secondLabel.textColor = .dark
        secondLabel.font = .customHeadline
        let thirdLabel = stackViews[2].subviews[0] as! UILabel
        thirdLabel.text =  editorState == .RGB ? .blue : .brightness
        thirdLabel.textColor = .dark
        thirdLabel.font = .customHeadline
        let opacityLabel = stackViews[3].subviews[0] as! UILabel
        opacityLabel.text = .opacity
        opacityLabel.textColor = .dark
        opacityLabel.font = .customHeadline
        
        firstSliderLabel.textColor = .dark
        firstSliderLabel.font = .customBody
        firstSliderLabel.text = editorState == .RGB ? currentColor.rString : currentColor.hString
        secondSliderLabel.textColor = .dark
        secondSliderLabel.font = .customBody
        secondSliderLabel.text = editorState == .RGB ? currentColor.gString : currentColor.sString
        thirdSliderLabel.textColor = .dark
        thirdSliderLabel.font = .customBody
        thirdSliderLabel.text = editorState == .RGB ? currentColor.bString : currentColor.vString
        opacitySliderLabel.textColor = .dark
        opacitySliderLabel.font = .customBody
        opacitySliderLabel.text = currentColor.opacityString
        
        let firstSlider = stackViews[0].subviews[1] as! UISlider
        firstSlider.tintColor = .lightContext
        firstSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let secondSlider = stackViews[1].subviews[1] as! UISlider
        secondSlider.tintColor = .lightContext
        secondSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let thirdSlider = stackViews[2].subviews[1] as! UISlider
        thirdSlider.tintColor = .lightContext
        thirdSlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        let opacitySlider = stackViews[3].subviews[1] as! UISlider
        opacitySlider.value = Float(currentColor.opacity)
        opacitySlider.tintColor = .lightContext
        opacitySlider.setThumbImage(.sliderIcon.maskWithColor(color: .darkContext), for: .normal)
        
        if editorState == .RGB {
            firstSlider.value = Float(currentColor.r)
            secondSlider.value = Float(currentColor.g)
            thirdSlider.value = Float(currentColor.b)
        } else if editorState == .HSB {
            firstSlider.value = Float(currentColor.h)
            secondSlider.value = Float(currentColor.s)
            thirdSlider.value = Float(currentColor.v)
        }
        
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
    
    func getColorState() -> UIColor {
        switch editorState {
        case .RGB:
            return currentColor.rgbColor
        case .HSB:
            return currentColor.hsbColor
        }
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
