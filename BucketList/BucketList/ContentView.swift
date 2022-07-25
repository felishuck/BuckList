//
//  ContentView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 20/07/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {

    @ObservedObject private var viewModel: ContentViewModel
    
    init() {
        viewModel = ContentViewModel()
    }
    
    var body: some View {
        
        if viewModel.isUnlocked {
            switch viewModel.loadingState{
            case .loading:
                LoadingView()
            case .loaded:
                MapView(viewModel)
            case .failed:
                ManualAuthenticationView(viewModel: viewModel)
            }
        } else {
            switch viewModel.authenticationMethod{
            case .biometrics:
                BiometricAuthentication(viewModel: viewModel)
            case .manual:
                ManualAuthenticationView(viewModel: viewModel)
            }
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
