//
//  Color.swift
//  TintThat
//
//  Created by Sebastian Cruz on 21/05/21.
//

import UIKit

struct Color {
    
    // MARK: - Properties
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    var rawColor: UIColor {
        UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
