//
//  Location.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 21/07/2022.
//

import Foundation
import CoreLocation
import SwiftUI

enum LocationType: String, CaseIterable, Codable {
    case house, car, person
    
    func getLocationTypeIconName()->String{
        switch self {
        case .house:
            return "house.fill"
        case .car:
            return "car.fill"
        case .person:
            return "person.fill"
        }
    }
    
    func getLocationTypeIconColor()->Color{
        switch self {
        case .house:
            return .red
        case .car:
            return .blue
        case .person:
            return .green
        }
    }
}

struct Location:Identifiable, Codable{
    let id:UUID
    var name:String
    var description:String
    var locationType: LocationType
    let coordinates: Coordinate
    var clLocationCoordinate2D: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    init(name:String, description: String, locationType: LocationType, coordinates: Coordinate){
        self.id = UUID()
        self.name = name
        self.description = description
        self.locationType = locationType
        self.coordinates = coordinates
    }
    
    init(id: UUID, name: String, description: String, locationType: LocationType, coordinates: Coordinate){
        self.id = id
        self.name = name
        self.description = description
        self.locationType = locationType
        self.coordinates = coordinates
    }
    
    static let example = Location(name: "Home",description: "The place where I was born", locationType: .car, coordinates: Coordinate(latitude: 36.45918527613726, longitude: -5.92721401486374))
}


extension Location: Equatable{
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
