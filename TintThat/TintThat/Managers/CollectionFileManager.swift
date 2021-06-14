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
        if let data = encode(collection: collection) {
            do {
                try data.write(to: getCollectionDirectory(collecionID: collection.id.uuidString), options: .atomic)
            } catch {
                // TODO: Handle if the user can´t save (Not needed for now)
            }
        }
    }
    
    static func getDecodedCollections() -> [Collection] {
        var collections = [Collection]()
        
        let urls = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        if let urls = urls {
            for url in urls {
                let data = try? Data(contentsOf: url)
                if let data = data, let collection = decode(collectionData: data) {
                    collections.append(collection)
                }
            }
        }
        
        return collections
    }
    
    static func getDecodedCollection(collectionID: String) -> Collection? {
        let data = FileManager.default.contents(atPath: getDocumentsDirectory().appendingPathComponent(collectionID).path)
        
        if let data = data, let collection = decode(collectionData: data) {
            return collection
        }
        
        return nil
    }
    
}
