//
//  LocationViewModel.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 25/07/2022.
//

import Foundation

@MainActor
class LocationViewModel: ObservableObject{
    var location: Location
    @Published var id: UUID
    @Published var newName: String
    @Published var newDescription: String
    @Published var newLocationType: LocationType
    
    @Published var nearbyInterestPoints: [Article] = []
    @Published var loadingState: LoadingState = .loading
    
    @Published var isDeleteConfirmationShown = false
    
    init(_ location: Location){
        self.location = location
        self.id = location.id
        self.newName = location.name
        self.newDescription = location.description
        self.newLocationType = location.locationType
    }
    
    func fetchInterestPoints() async {
        let stringURL = "https://en.wikipedia.org/w/api.php?action=query&list=geosearch&gscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&gsradius=10000&gslimit=50&format=json"
        guard let url = URL(string: stringURL) else {return}
        Task{
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let newRequest = try JSONDecoder().decode(Request.self, from: data)
            await MainActor.run {
                nearbyInterestPoints = newRequest.query.articles
                loadingState = .loaded
            }
        }catch{
            await MainActor.run{
                loadingState = .failed
            }
        }
        }
    }
    
    func getNewLocation()->Location{
        return Location(id: id, name: newName, description: newDescription, locationType: newLocationType, coordinates: location.coordinates)
    }
    
    func showDeleteConfirmationDialogue(){
        isDeleteConfirmationShown = true
    }
}
