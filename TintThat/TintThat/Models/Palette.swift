//
//  Palette.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

struct Palette: Codable {
    
    // MARK: - Properties
    private var title: String
    private var colors: [Color]
    
    var count: Int {
        colors.count
    }
    
    // MARK: - Constructors
    init(colors: [Color]) {
        self.colors = colors
        self.title = .myPalette
    }
    
    init(title: String, colors: [Color]) {
        self.title = title
        self.colors = colors
    }
    
}

// MARK: - Private
extension Palette {
    
    func colorIn(row: Int) -> Color {
        return colors[row]
    }
    
}
