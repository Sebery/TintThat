//
//  ColorPickerViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 22/05/21.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    // MARK: - Properties
    var currentColor = Color(r: 0.0, g: 0.0, b: 0.0)
    
    enum SliderTag: Int {
        case rSlider = 1000
        case gSlider = 1001
        case bSlider = 1002
    }
    
    // MARK: Outlets
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    // MARK: - Custom Methods
    private func UpdateUI() {
        colorView.backgroundColor = currentColor.rawColor
        rSlider.value = Float(currentColor.r)
        gSlider.value = Float(currentColor.g)
        bSlider.value = Float(currentColor.b)
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var colorView: UIView!
    
    // MARK: - Actions
    @IBAction func ChangeColor(_ slider: UISlider) {
        let sliderTag = SliderTag(rawValue: slider.tag)
        let sliderValue = CGFloat(slider.value)
        
        switch sliderTag {
        case .rSlider:
            currentColor.r = sliderValue
        case .gSlider:
            currentColor.g = sliderValue
        case .bSlider:
            currentColor.b = sliderValue
        case .none:
            break
        }
        
        colorView.backgroundColor = currentColor.rawColor
    }

}
