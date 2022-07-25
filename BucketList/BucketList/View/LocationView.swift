//
//  LocationView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 21/07/2022.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: LocationViewModel
    
    var onSave:((Location)->())
    var onDelete:((Location)->())
    
    init(location:Location, onSave: @escaping ((Location)->()), onDelete: @escaping ((Location)->())){
        _viewModel = StateObject(wrappedValue: LocationViewModel(location))
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section("NAME"){
                    TextField("Location name", text: $viewModel.newName)
                }
                Section("description"){
                    TextEditor(text: $viewModel.newDescription)
                }
                Section{
                    Picker("Type", selection: $viewModel.newLocationType) {
                        ForEach(LocationType.allCases, id:\.self){ locaType in
                            Text(locaType.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Coordinates"){
                    Group{
                        Text("Latitud: \(viewModel.location.coordinates.latitude)")
                        Text("Longitude: \(viewModel.location.coordinates.longitude)")
                    }.foregroundColor(.secondary)
                }
                
                if !viewModel.nearbyInterestPoints.isEmpty{
                    Section("Points of Interest"){
                        switch viewModel.loadingState {
                        case .loading:
                            Text("Loading…")
                        case .loaded:
                            ForEach(viewModel.nearbyInterestPoints) { point in
                                HStack{
                                    Text(point.title)
                                    Spacer()
                                    Text(point.distance >= 1000 ? "\(Int(point.distance/1000))km" : "\(Int(point.distance))m")
                                        .italic()
                                        .foregroundColor(.secondary)
                                }
                            }
                        case .failed:
                            Text("Loading failed. Try it later again.")
                        }
                    }
                }
                
                Section{
                    Button("Save"){
                        saveButtonWasTapped()
                    }
                    Button("Delete", role: .destructive){
                        deleteButtonWasTapped()
                    }
                }
            }.task {
                await viewModel.fetchInterestPoints()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        cancelButtonWasTapped()
                    }
                }
                
            }.alert("Delete Location", isPresented: $viewModel.isDeleteConfirmationShown, actions: {
                Button("Delete", role: .destructive){
                    deleteConfirmationDialagueTapped()
                }
            }, message: {
                Text("Do you really want to delete this location?")
            })
            .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Place details")
        }
    }
    
    func saveButtonWasTapped(){
        onSave(viewModel.getNewLocation())
        dismiss()
    }
    
    func cancelButtonWasTapped(){
        dismiss()
    }
    
    func deleteButtonWasTapped(){
        viewModel.showDeleteConfirmationDialogue()
    }
    
    func deleteConfirmationDialagueTapped(){
        onDelete(viewModel.getNewLocation())
        dismiss()
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: Location.example) { _ in
            
        } onDelete: { _ in
            
        }

    }
}

enum LoadingState{
    case loading, loaded, failed
}
