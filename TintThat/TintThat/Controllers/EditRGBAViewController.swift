//
//  EditRGBAViewController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 11/06/21.
//

import UIKit

final class EditRGBAViewController: UIViewController {
    
    // MARK: - Properties
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
        view.backgroundColor = .primaryLight
        
        // Setup color view
        view.subviews[0].backgroundColor = .primaryLight
        view.subviews[0].subviews[0].backgroundColor = currentColor.color
        view.subviews[0].subviews[0].layer.cornerRadius = 8.0
        
        // Setup RGBA view
        let stackViews = view.subviews[1].subviews
        let redLabel = stackViews[0].subviews[0] as! UILabel
        redLabel.text = .red
        let greenLabel = stackViews[1].subviews[0] as! UILabel
        greenLabel.text = .green
        let blueLabel = stackViews[2].subviews[0] as! UILabel
        blueLabel.text = .blue
        let alphaLabel = stackViews[3].subviews[0] as! UILabel
        alphaLabel.text = .alpha
        
        let redSliderLabel = stackViews[0].subviews[1].subviews[0] as! UILabel
        redSliderLabel.text = currentColor.rTo255
        let greenSliderLabel = stackViews[1].subviews[1].subviews[0] as! UILabel
        greenSliderLabel.text = currentColor.gTo255
        let blueSliderLabel = stackViews[2].subviews[1].subviews[0] as! UILabel
        blueSliderLabel.text = currentColor.bTo255
        let alphaSliderLabel = stackViews[3].subviews[1].subviews[0] as! UILabel
        alphaSliderLabel.text = currentColor.aTo255
        
        self.redSliderLabel = redSliderLabel
        self.greenSliderLabel = greenSliderLabel
        self.blueSliderLabel = blueSliderLabel
        self.alphaSliderLabel = alphaSliderLabel
        
        let redSlider = stackViews[0].subviews[1].subviews[1] as! UISlider
        redSlider.value = Float(currentColor.r)
        let greenSlider = stackViews[1].subviews[1].subviews[1] as! UISlider
        greenSlider.value = Float(currentColor.g)
        let blueSlider = stackViews[2].subviews[1].subviews[1] as! UISlider
        blueSlider.value = Float(currentColor.b)
        let alphaSlider = stackViews[3].subviews[1].subviews[1] as! UISlider
        alphaSlider.value = Float(currentColor.a)
    }
    
}
