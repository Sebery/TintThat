//
//  UIColor+RGBA.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

extension UIColor {
    
    var a: CGFloat {
        var value: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &value)
        return value
    }
    
    // RGB
    var r: CGFloat {
        var value: CGFloat = 0.0
        getRed(&value, green: nil, blue: nil, alpha: nil)
        return value
    }
    
    var g: CGFloat {
        var value: CGFloat = 0.0
        getRed(nil, green: &value, blue: nil, alpha: nil)
        return value
    }
    
    var b: CGFloat {
        var value: CGFloat = 0.0
        getRed(nil, green: nil, blue: &value, alpha: nil)
        return value
    }
    
    // HSB
    var h: CGFloat {
        var value: CGFloat = 0.0
        getHue(&value, saturation: nil, brightness: nil, alpha: nil)
        return value
    }
    
    var s: CGFloat {
        var value: CGFloat = 0.0
        getHue(nil, saturation: &value, brightness: nil, alpha: nil)
        return value
    }
    
    var v: CGFloat {
        var value: CGFloat = 0.0
        getHue(nil, saturation: nil, brightness: &value, alpha: nil)
        return value
    }
}
