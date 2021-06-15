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
    private var colorsProp: [Color]
    
    var count: Int {
        colors.count
    }
    
    var title: String {
        get { titleProp }
        set { titleProp = newValue }
    }
    
    var colors: [Color] {
        get { colorsProp }
    }
    
    // MARK: - Constructors
    init(colors: [Color]) {
        self.colorsProp = colors
        self.titleProp = .myPalette
    }
    
    init(title: String, colors: [Color]) {
        self.titleProp = title
        self.colorsProp = colors
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case titleProp = "title"
        case colorsProp = "colors"
    }
    
}

// MARK: - Private
extension Palette {
    
    func colorIn(row: Int) -> Color {
        return colors[row]
    }
    
    mutating func appendColor() {
        let secondaryColors = [UIColor.secondary01, UIColor.secondary02, UIColor.secondary03]
        colorsProp.append(Color(rgbColor: secondaryColors[Int.random(in: 0..<3)]))
    }
    
    mutating func setColorIn(row: Int, withColor color: Color) {
        colorsProp[row] = color
    }
    
}
