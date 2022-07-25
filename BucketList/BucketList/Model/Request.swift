//
//  Article.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 22/07/2022.
//

import Foundation

struct Request: Codable{
    var query:Query
}

struct Query: Codable{
    enum CodingKeys: String, CodingKey{
        case articles = "geosearch"
    }
    var articles:[Article]
}

struct Article: Codable, Identifiable{
    enum CodingKeys: String, CodingKey{
        case id = "pageid", title, latitude = "lat", longitude = "lon", distance = "dist"
    }
    var id: Int
    var title:String
    var latitude: Double
    var longitude: Double
    var distance: Double
}
