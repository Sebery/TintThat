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
        titleProp
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
    
}
