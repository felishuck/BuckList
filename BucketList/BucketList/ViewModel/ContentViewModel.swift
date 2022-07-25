//
//  ContentViewModel.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 23/07/2022.
//

import Foundation
import MapKit
import LocalAuthentication

@MainActor
class ContentViewModel: ObservableObject{
    @Published var loadingState: LoadingState = .loading
    
    @Published var isUnlocked: Bool = false
    @Published var authenticationMethod: AuthenticationMethod = .biometrics
    
    @Published var annotations:[Location] = []
    
    @Published var selectedLocation: Location?
    
    @Published var currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.39, longitude: -6.39), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @Published var user: String = ""
    @Published var password: String = ""
    
    @Published var isDeleteAlertShown = false
    

    func createAnotation(){
        let newLocation = Location(name: "", description: "", locationType: .car, coordinates: Coordinate(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude))
        selectedLocation = newLocation
    }
    
    func updateAnnotation(_ newLocation:Location, to oldLocation:Location){
        guard let index = annotations.firstIndex(of: oldLocation) else {return}
        annotations.remove(at: index)
        annotations.insert(newLocation, at: index)
        save()
        print("Correctly saved")
    }
    
    func addAnnotation(_ newLocation:Location){
        annotations.append(newLocation)
        save()
        print("Correctly saved")
    }
    
    func deleteAnnotation(_ location: Location){
        if let index = annotations.firstIndex(of: location){
            annotations.remove(at: index)
            save()
        }
    }
    
    func save(){
        FileManager.save(annotations)
    }
    
    func load(){
        loadingState = .loading
        annotations = FileManager.load() ?? []
        loadingState = .loaded
    }
    
    func resetLogInData(){
        user = ""
        password = ""
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        let reasonMessage = "Authentication with biometrics is necessary to get access to your data"
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            loadingState = .failed
            return
        }
        
        Task{
                do {
                    try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonMessage)
                    await MainActor.run {
                        isUnlocked = true
                        load()
                    }
                } catch {
                    await MainActor.run{
                        loadingState = .failed
                    }
                }
            }
        }
    }

