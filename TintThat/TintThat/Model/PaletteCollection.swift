//
//  PaletteCollection.swift
//  TintThat
//
//  Created by Sebastian Cruz on 05/06/21.
//

import UIKit

struct PaletteCollection: Codable {
    
    // MARK: - Properties
    private var titleP: String
    private var id = UUID()
    private var palettes: [Palette]
    
    var isEmpty: Bool {
        palettes.isEmpty
    }
    
    var count: Int {
        palettes.count
    }
    
    // MARK: - Constructors
    init(title: String, palettes: [Palette]) {
        self.titleP = title
        self.palettes = palettes
    }
    
    // MARK: Custom methods
    func numberOfColors(in section: Int) -> Int {
        return palettes[section].count
    }
    
}
