//
//  String+LocalizableKeys.swift
//  TintThat
//
//  Created by Sebastian Cruz on 08/06/21.
//

import UIKit

extension String {
    
    /* Palette model */
    static var myPalette: String { NSLocalizedString("myPalette", comment: "") }
    
    /* Main tab bar */
    static var editor: String { NSLocalizedString("editor", comment: "") }
    static var myPalettes: String { NSLocalizedString("myPalettes", comment: "") }
    static var settings: String { NSLocalizedString("settings", comment: "") }

    /* Editor view controller */
    static var loadedOrCreated: String { NSLocalizedString("loadedOrCreated", comment: "") }
    static var notLoadedOrCreated: String { NSLocalizedString("notLoadedOrCreated", comment: "") };
    
    /* Options view controller */
    static var options: String { NSLocalizedString("options", comment: "") }
    static var load: String { NSLocalizedString("load", comment: "") }
    static var create: String { NSLocalizedString("create", comment: "") }
    static var addPalette: String { NSLocalizedString("addPalette", comment: "") }
    
    /* Create view controller */
    static var nameCollection: String { NSLocalizedString("nameCollection", comment: "") }
    static var maxChar: String { NSLocalizedString("maxChar", comment: "") }
    static var maxCharError: String { NSLocalizedString("maxCharError", comment: "") }
    static var maxCharErrorCause: String { NSLocalizedString("maxCharErrorCause", comment: "") }
    static var emptyCharError: String { NSLocalizedString("emptyCharError", comment: "") }
    
    /* Delete palette view controller */
    static var delete: String { NSLocalizedString("delete", comment: "") }
    static var deleteMessage: String { NSLocalizedString("deleteMessage", comment: "") }
    
    /* Load view controller */
    static var emptyLoads: String { NSLocalizedString("emptyLoads", comment: "") }
    
    /* Edit Palette Name */
    static var editPaletteName: String { NSLocalizedString("editPaletteName", comment: "") }
    static var save: String { NSLocalizedString("save", comment: "") }
    
    /* Color editor view controller */
    static var editColor: String { NSLocalizedString("editColor", comment: "") }
    static var searchColor: String { NSLocalizedString("searchColor", comment: "") }
    static var editRGBA: String { NSLocalizedString("editRGBA", comment: "") }
    
    /* Edit RGBA view controller */
    static var red: String { NSLocalizedString("red", comment: "") }
    static var green: String { NSLocalizedString("green", comment: "") }
    static var blue: String { NSLocalizedString("blue", comment: "") }
    static var alpha: String { NSLocalizedString("alpha", comment: "") }
    
}
