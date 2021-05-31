//
//  Palette.swift
//  TintThat
//
//  Created by Sebastian Cruz on 26/05/21.
//

import UIKit

struct Palette: Codable {
    
    // MARK: - Properties
    private let section: Int
    var colors: [Color]
    var title: String
    
    // MARK: - Constructors
    init(section: Int, withColors colors: [Color]) {
        self.section = section
        self.colors = colors
        self.title = ""
    }
    
    init(section: Int, withColors colors: [Color], withTitle title: String) {
        self.section = section
        self.colors = colors
        self.title = title
    }
}
