//
//  Collection.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

struct Collection: Codable {
    
    // MARK: - Properties
    private var titleProp: String
    private var idProp = UUID()
    private var palettes: [Palette]
    
    var title: String {
        titleProp
    }
    
    var isEmpty: Bool {
        palettes.isEmpty
    }
    
    var count: Int {
        palettes.count
    }
    
    var id: UUID {
        idProp
    }
    
    // MARK: - Constructors
    init(title: String, palettes: [Palette]) {
        self.titleProp = title
        self.palettes = palettes
    }
    
}

// MARK: - Public
extension Collection {
    
    func numberOfColors(in section: Int) -> Int {
        return palettes[section].count
    }
    
    func colorOfPalette(in section: Int, forRow row: Int) -> Color {
        return palettes[section].colorIn(row: row)
    }
    
    func titleOfPalette(in section: Int) -> String {
        return palettes[section].title
    }
    
    mutating func addPalette(palette: Palette) {
        palettes.append(palette)
    }
    
}


