//
//  RGBAEditorViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 30/05/21.
//

import UIKit

class RGBAEditorViewController: UIViewController {

    // MARK: - Properties
    private var currentColor = Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) {
        didSet {
            colorView.backgroundColor = currentColor.color
        }
    }
    weak var colorEditorVC: ColorEditorViewController?
    
    enum Tag: Int {
        case rSlider = 1000
        case gSlider = 1001
        case bSlider = 1002
        case aSlider = 1003
    }
    
    // MARK: - Outlets
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var aSlider: UISlider!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var aLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func changeColor(sender: UISlider) {
        let tag = Tag(rawValue: sender.tag)
        
        switch tag {
        case .rSlider:
            currentColor.r = CGFloat(sender.value)
            rLabel.text = currentColor.rTo255
        case .gSlider:
            currentColor.g = CGFloat(sender.value)
            gLabel.text = currentColor.gTo255
        case .bSlider:
            currentColor.b = CGFloat(sender.value)
            bLabel.text = currentColor.bTo255
        case .aSlider:
            currentColor.a = CGFloat(sender.value)
            aLabel.text = currentColor.aTo255
        case .none:
            return
        }
    }
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var title: String = ""
        if colorEditorVC?.state == .addColor {
            title = "Add Color"
        } else if colorEditorVC?.state == .editColor, let colorEditorVC = colorEditorVC, let color = colorEditorVC.paletteCollectionEditorVC?.getColorFromPalette(forSection: colorEditorVC.colorPath.section, inRow: colorEditorVC.colorPath.row) {
            title = "Save Changes"
            currentColor = color
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(doneWithColor))
        
        setDefaultColor()
    }
    
    // MARK: - Custom methods
    private func setDefaultColor() {        
        colorView.backgroundColor = currentColor.color
        rSlider.value = Float(currentColor.r)
        gSlider.value = Float(currentColor.g)
        bSlider.value = Float(currentColor.b)
        aSlider.value = Float(currentColor.a)
        rLabel.text = currentColor.rTo255
        gLabel.text = currentColor.gTo255
        bLabel.text = currentColor.bTo255
        aLabel.text = currentColor.aTo255
    }
    
    // MARK: - Selectors
    @objc func doneWithColor() {
        
        if let colorEditorVC = colorEditorVC {
            if colorEditorVC.state == .addColor {
                colorEditorVC.paletteCollectionEditorVC?.addColorToPalette(forSection: colorEditorVC.colorPath.section, andColor: currentColor)
                navigationController?.popToRootViewController(animated: true)

            } else if colorEditorVC.state == .editColor {
                dismiss(animated: true, completion: { [weak self] in
                    if let controller = self, let indexPath = controller.colorEditorVC?.colorPath {
                        controller.colorEditorVC?.paletteCollectionEditorVC?.setColorInPalette(forSection: indexPath.section, inRow: indexPath.row, withColor: controller.currentColor)
                    }
                })
            }
        }

    }

}
