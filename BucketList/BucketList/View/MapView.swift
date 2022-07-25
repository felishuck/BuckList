//
//  MapView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 24/07/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(_ viewModel: ContentViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.currentRegion, annotationItems: viewModel.annotations){ location in
                MapAnnotation(coordinate: location.clLocationCoordinate2D) {
                    Image(systemName: location.locationType.getLocationTypeIconName())
                        .foregroundColor(location.locationType.getLocationTypeIconColor())
                        .frame(width: 44, height: 44)
                        .shadow(color: .black, radius: 5, x: 0, y: 0)
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                }
            }
            Circle()
                .opacity(0.3)
                .frame(width: 25, height: 25)
            VStack{
                Spacer()
                HStack(alignment: .bottom){
                    Spacer()
                    Button {
                        viewModel.createAnotation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(.red)
                            .background(.thinMaterial)
                            .clipShape(Circle())
                    }.shadow(radius: 5, x: 0, y: 0)
                }
            }.padding()
        }.edgesIgnoringSafeArea(.all)
        .sheet(item: $viewModel.selectedLocation) { location in
            LocationView(location: location){newLocation in
                if viewModel.annotations.contains(newLocation){
                    viewModel.updateAnnotation(newLocation, to: location)
                } else {
                    viewModel.addAnnotation(newLocation)
                }
            } onDelete: { locationToDelete in
                viewModel.deleteAnnotation(locationToDelete)
            }
        }

    }
    
}

struct MapView_Previews: PreviewProvider {
    static let viewModel = ContentViewModel()
    static var previews: some View {
        MapView(viewModel)
    }
}
