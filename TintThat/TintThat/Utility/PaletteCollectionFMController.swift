//
//  PaletteCollectionFMController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 31/05/21.
//

import UIKit

class PaletteCollectionFM {
    
    // MARK: - Custom methods
    static func getDocumentsDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[0]
    }
    
    static func getPaletteColectionDirectory(fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    static func getDecodedCollections() -> [PaletteCollection] {
        var collections = [PaletteCollection]()
        
        let urls = try? FileManager.default.contentsOfDirectory(at: PaletteCollectionFM.getDocumentsDirectory(), includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        if let urls = urls {
            for url in urls {
                let data = try? Data(contentsOf: url)
                if let data = data, let collection = PaletteCollectionFM.decode(paletteCollectionData: data) {
                    collections.append(collection)
                }
            }
        }
        
        return collections
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
