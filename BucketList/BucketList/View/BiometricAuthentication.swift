//
//  BiometricAuthentication.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 24/07/2022.
//

import SwiftUI

struct BiometricAuthentication: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            MapImageView()
            Button("Access with Face Id"){
                viewModel.authenticate()
            }.padding()
                .background(.thinMaterial)
                .clipShape(Capsule())
            .foregroundColor(.secondary)
            .shadow(radius: 10, x: 0, y: 0)
            VStack{
                Spacer()
                Button("Log In Manually"){
                    viewModel.authenticationMethod = .manual
                }.padding(.bottom, 20)
                    .foregroundColor(.white)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct BiometricAuthentication_Previews: PreviewProvider {
    static var viewModel = ContentViewModel()

    static var previews: some View {
        BiometricAuthentication(viewModel: viewModel)
    }
}
