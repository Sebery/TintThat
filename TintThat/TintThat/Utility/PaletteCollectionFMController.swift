//
//  PaletteCollectionFMController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 31/05/21.
//

import UIKit

class PaletteCollectionFM {
    
    // MARK: - Custom methods
    static func getPaletteColectionDirectory(fileName: String) -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent(fileName)
    }
    
    static func encode(paletteCollection: PaletteCollection) -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(paletteCollection)
        return data
    }
    
    static func decode(paletteCollectionData: Data) -> PaletteCollection? {
        let decoder = JSONDecoder()
        let paletteCollection = try? decoder.decode(PaletteCollection.self, from: paletteCollectionData)
        
        return paletteCollection
    }
    
}
