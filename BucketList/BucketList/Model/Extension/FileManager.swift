//
//  FileManager.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 24/07/2022.
//

import Foundation

extension FileManager {
    static func getFileUrl(fileName: String)->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }
    
    static func save<T: Codable>(_ object: T){
        let url = FileManager.getFileUrl(fileName: "dataSaving")
        do{
            let data = try JSONEncoder().encode(object)
            try data.write(to: url, options: .completeFileProtection)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func load<T: Codable>()->T?{
        let url = FileManager.getFileUrl(fileName: "dataSaving")
        do{
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
