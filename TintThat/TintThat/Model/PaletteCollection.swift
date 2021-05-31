//
//  PaletteCollection.swift
//  TintThat
//
//  Created by Sebastian Cruz on 31/05/21.
//

import UIKit

struct PaletteCollection: Codable {
    
    // MARK: - Properties
    var title: String
    var id = UUID()
    var palettes: [Palette]
    
    // MARK: - Constructors
    init(title: String, palettes: [Palette]) {
        self.title = title
        self.palettes = palettes
    }
    
    init() {
        title = ""
        palettes = [Palette]()
    }
}
