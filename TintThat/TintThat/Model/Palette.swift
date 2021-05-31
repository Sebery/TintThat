//
//  Palette.swift
//  TintThat
//
//  Created by Sebastian Cruz on 26/05/21.
//

import UIKit

struct Palette {
    private let section: Int
    var colors: [Color]
    var title: String = "My Palette"
    
    init(section: Int, withColors colors: [Color]) {
        self.section = section
        self.colors = colors
    }
}
