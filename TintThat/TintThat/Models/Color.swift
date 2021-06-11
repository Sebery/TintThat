//
//  Color.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

struct Color: Codable {
    
    // MARK: - Properties
    private lazy var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
    
    private var rgba: [CGFloat]
    
    var color: UIColor {
        UIColor(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    var r: CGFloat {
        get { rgba[0] }
        set { rgba[0] = newValue }
    }
    
    var g: CGFloat {
        get { rgba[1] }
        set { rgba[1] = newValue }
    }
    
    var b: CGFloat {
        get { rgba[2] }
        set { rgba[2] = newValue }
    }
    
    var a: CGFloat {
        get { rgba[3] }
        set { rgba[3] = newValue }
    }
    
    var rTo255: String {
        mutating get { formatter.string(from: NSNumber(value: Double(rgba[0]) * 255.0)) ?? "" }
    }
    
    var gTo255: String {
        mutating get { formatter.string(from: NSNumber(value: Double(rgba[1]) * 255.0)) ?? "" }
    }
    
    var bTo255: String {
        mutating get { formatter.string(from: NSNumber(value: Double(rgba[2]) * 255.0)) ?? "" }
    }
    
    var aTo255: String {
        mutating get { formatter.string(from: NSNumber(value: Double(rgba[3]) * 255.0)) ?? "" }
    }
    
    // MARK: - Constructors
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        rgba = [red, green, blue, alpha]
    }
    
    init(color: UIColor) {
        self.init(red: color.r, green: color.g, blue: color.b, alpha: color.a)
    }
    

    
}

