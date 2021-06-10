//
//  CollectionFileManager.swift
//  TintThat
//
//  Created by Sebastian Cruz on 10/06/21.
//

import UIKit

struct CollectionFileManager {
    
    static func getDocumentsDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return urls[0]
    }
    
    static func getCollectionDirectory(collecionID: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(collecionID)
    }
    
    static func encode(collection: Collection) -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(collection)
        
        return data
    }
    
    static func decode(collectionData: Data) -> Collection? {
        let decoder = JSONDecoder()
        let collection = try? decoder.decode(Collection.self, from: collectionData)
        
        return collection
    }
    
    static func saveCollection(collection: Collection) {
        if let data = CollectionFileManager.encode(collection: collection) {
            do {
                try data.write(to: CollectionFileManager.getCollectionDirectory(collecionID: collection.id.uuidString), options: .atomic)
            } catch {
                // TODO: Handle if the user can´t save (Not needed for now)
            }
        }
    }
    
    
    
}
