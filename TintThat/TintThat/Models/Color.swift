//
//  Color.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

struct Color: Codable {
    
    // MARK: - Propeties
    private lazy var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
    
    private var rgbProp: [CGFloat]
    private var hsbProp: [CGFloat]
    private var opacityProp: CGFloat
    
    var rgbColor: UIColor {
        UIColor(red: rgbProp[0], green: rgbProp[1], blue: rgbProp[2], alpha: opacityProp)
    }
    
    var hsbColor: UIColor {
        UIColor(hue: hsbProp[0], saturation: hsbProp[1], brightness: hsbProp[2], alpha: opacityProp)
    }
    
    // RGB
    var r: CGFloat {
        get { rgbProp[0] }
        set {
            rgbProp[0] = newValue
            hsbProp = [rgbColor.h, rgbColor.s, rgbColor.v]
        }
    }
    
    var g: CGFloat {
        get { rgbProp[1] }
        set {
            rgbProp[1] = newValue
            hsbProp = [rgbColor.h, rgbColor.s, rgbColor.v]
        }
    }
    
    var b: CGFloat {
        get { rgbProp[2] }
        set {
            rgbProp[2] = newValue
            hsbProp = [rgbColor.h, rgbColor.s, rgbColor.v]
        }
    }
    
    var rString: String {
        mutating get { formatter.string(from: (rgbProp[0] * 255.0) as NSNumber) ?? "" }
    }
    var gString: String {
        mutating get { formatter.string(from: (rgbProp[1] * 255.0) as NSNumber) ?? "" }
    }
    
    var bString: String {
        mutating get { formatter.string(from: (rgbProp[2] * 255.0) as NSNumber) ?? "" }
    }
    
    // HSB
    var h: CGFloat {
        get { hsbProp[0] }
        set {
            hsbProp[0] = newValue
            rgbProp = [hsbColor.r, hsbColor.g, hsbColor.b]
        }
    }
    
    var s: CGFloat {
        get { hsbProp[1] }
        set {
            hsbProp[1] = newValue
            rgbProp = [hsbColor.r, hsbColor.g, hsbColor.b]
        }
    }
    
    var v: CGFloat { // B
        get { hsbProp[2] }
        set {
            hsbProp[2] = newValue
            rgbProp = [hsbColor.r, hsbColor.g, hsbColor.b]
        }
    }
    
    var hString: String {
        mutating get {
            if let string = formatter.string(from: (hsbProp[0] * 360.0) as NSNumber) {
                return string + "º"
            }
             
            return ""
        }
    }
    
    var sString: String {
        mutating get {
            if let string = formatter.string(from: (hsbProp[1] * 100.0) as NSNumber) {
                return string + "%"
            }
             
            return ""
        }
    }
    
    var vString: String { // B
        mutating get {
            if let string = formatter.string(from: (hsbProp[2] * 100.0) as NSNumber) {
                return string + "%"
            }
             
            return ""
        }
    }
    
    // Opacity
    var opacityString: String {
        mutating get {
            if let string = formatter.string(from: (opacityProp * 100.0) as NSNumber) {
                return string + "%"
            }
             
            return ""
        }
    }
    
    var opacity: CGFloat {
        get { opacityProp }
        set { opacityProp = newValue }
    }
    
    // MARK: - Constructors
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        rgbProp = [red, green, blue, alpha]
        opacityProp = alpha
        let tempColor = UIColor(red: rgbProp[0], green: rgbProp[1], blue: rgbProp[2], alpha: opacityProp)
        hsbProp = [tempColor.h, tempColor.s, tempColor.v]
    }
    
    init(rgbColor: UIColor) {
        rgbProp = [rgbColor.r, rgbColor.g, rgbColor.b]
        opacityProp = rgbColor.a
        hsbProp = [rgbColor.h, rgbColor.s, rgbColor.v]
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case rgbProp = "rgb"
        case hsbProp = "hsb"
        case opacityProp = "opacity"
    }
    
}
