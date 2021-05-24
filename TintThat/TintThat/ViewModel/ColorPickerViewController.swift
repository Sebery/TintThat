//
//  ColorPickerViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 22/05/21.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    // MARK: - Properties
    var currentColor = Color(r: 0.0, g: 0.0, b: 0.0, indexPath: nil)
    var currentSection: Int?
    
    enum SliderTag: Int {
        case rSlider = 1000
        case gSlider = 1001
        case bSlider = 1002
    }
    
    // MARK: - Custom Methods
    private func updateUI() {
        colorView.backgroundColor = currentColor.rawColor
        rSlider.value = Float(currentColor.r)
        gSlider.value = Float(currentColor.g)
        bSlider.value = Float(currentColor.b)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    // MARK: - Actions
    @IBAction func discardChanges() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveChanges() {
        if let paletteCreatorController = navigationController?.viewControllers.first as? PaletteCreatorViewController {
            
            if let indexPath = currentColor.indexPath {
                paletteCreatorController.dataSource[indexPath.section][indexPath.row] = currentColor
            } else if let section = currentSection {
                let indexPath = IndexPath(row: paletteCreatorController.dataSource[section].count, section: section)
                paletteCreatorController.dataSource[section].append(Color(r: currentColor.r, g: currentColor.g, b: currentColor.b, indexPath: indexPath))
            }
            
            paletteCreatorController.colorsTableView.reloadData()
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func changeColor(_ slider: UISlider) {
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
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

}
