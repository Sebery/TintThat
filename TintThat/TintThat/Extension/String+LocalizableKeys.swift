//
//  String+LocalizableKeys.swift
//  TintThat
//
//  Created by Sebastian Cruz on 04/06/21.
//

import Foundation

extension String {
    
    // Main tab bar items
    static var editor: String { NSLocalizedString("editor", comment: "") }
    static var myPalettes: String { NSLocalizedString("myPalettes", comment: "") }
    static var settings: String { NSLocalizedString("settings", comment: "") }
    
    /* Palette model */
    static var myPalette: String { NSLocalizedString("myPalette", comment: "") }
    
    /* PCEditorVC */
    static var noCollection: String { NSLocalizedString("noCollection", comment: "") }
    
    /* PCOptionsVC */
    static var load: String { NSLocalizedString("load", comment: "") }
    static var create: String { NSLocalizedString("create", comment: "") }
    static var addPalette: String { NSLocalizedString("addPalette", comment: "") }
    static var pcOptions: String { NSLocalizedString("pcOptions", comment: "") }
    
}
