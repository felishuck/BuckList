//
//  ManualAuthenticationView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 24/07/2022.
//

import SwiftUI

struct ManualAuthenticationView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            MapImageView()
            VStack{
                Group{
                TextField("User name", text: $viewModel.user)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                    .frame(height: 30)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                    .frame(height: 30)
            }.frame(width: 150, height: 50)
            Button("Log In"){
                
            }.foregroundColor(.white)
            }
            VStack{
                Spacer()
                Button {
                    viewModel.resetLogInData()
                    viewModel.authenticationMethod = .biometrics
                } label: {
                    Label {
                        Text("Face Id")
                    } icon: {
                        Image(systemName: "faceid")
                    }.foregroundColor(.white)
                }.padding(.bottom, 20)

            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ManualAuthenticationView_Previews: PreviewProvider {
    static let viewModel = ContentViewModel()

    static var previews: some View {
        ManualAuthenticationView(viewModel: viewModel)
    }
}
