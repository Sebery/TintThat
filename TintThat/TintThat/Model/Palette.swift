//
//  Palette.swift
//  TintThat
//
//  Created by Sebastian Cruz on 26/05/21.
//

import UIKit

struct Palette {
    private let section: Int
    var colors: [UIColor]
    
    init(section: Int, withColors colors: [UIColor]) {
        self.section = section
        self.colors = colors
    }
}
