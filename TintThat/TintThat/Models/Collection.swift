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
    private var palettesProp: [Palette]
    
    var title: String {
        titleProp
    }
    
    var isEmpty: Bool {
        palettesProp.isEmpty
    }
    
    var count: Int {
        palettesProp.count
    }
    
    var id: UUID {
        idProp
    }
    
    // MARK: - Constructors
    init(title: String, palettes: [Palette]) {
        self.titleProp = title
        self.palettesProp = palettes
    }
    
    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case titleProp = "title"
        case idProp = "id"
        case palettesProp = "palettes"
    }
    
}

// MARK: - Public
extension Collection {
    
    func numberOfColors(in section: Int) -> Int {
        return palettesProp[section].count
    }
    
    func colorOfPalette(in section: Int, forRow row: Int) -> Color {
        return palettesProp[section].colorIn(row: row)
    }
    
    func titleOfPalette(in section: Int) -> String {
        return palettesProp[section].title
    }
    
    mutating func addPalette(palette: Palette) {
        palettesProp.append(palette)
    }
    
    mutating func deletePalette(inSection section: Int) {
        palettesProp.remove(at: section)
    }
    
    mutating func setTitleOfPalette(inSection section: Int, withName name: String) {
        palettesProp[section].title = name
    }
    
    mutating func setColorOfPalette(inPath path: IndexPath, withColor color: Color) {
        palettesProp[path.section].setColorIn(row: path.row, withColor: color)
    }
    
    // Returns the index of the color added to the palette
    mutating func addColorToPalette(inSection section: Int) -> Int {
        palettesProp[section].appendColor()
        
        return palettesProp[section].count - 1
    }
    
}


