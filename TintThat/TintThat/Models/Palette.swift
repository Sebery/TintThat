//
//  Palette.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

struct Palette: Codable {
    
    // MARK: - Properties
    private var titleProp: String
    private var colors: [Color]
    
    var count: Int {
        colors.count
    }
    
    var title: String {
        get { titleProp }
        set { titleProp = newValue }
    }
    
    // MARK: - Constructors
    init(colors: [Color]) {
        self.colors = colors
        self.titleProp = .myPalette
    }
    
    init(title: String, colors: [Color]) {
        self.titleProp = title
        self.colors = colors
    }
    
}

// MARK: - Private
extension Palette {
    
    func colorIn(row: Int) -> Color {
        return colors[row]
    }
    
    mutating func appendColor() {
        let secondaryColors = [UIColor.secondary01, UIColor.secondary02, UIColor.secondary03]
        colors.append(Color(rgbColor: secondaryColors[Int.random(in: 0..<3)]))
    }
    
    mutating func setColorIn(row: Int, withColor color: Color) {
        colors[row] = color
    }
    
}
