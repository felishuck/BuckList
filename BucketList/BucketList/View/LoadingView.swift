//
//  LoadingView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 24/07/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            Text("Loading…")
                .foregroundColor(.white)
                .font(.title)
        }.edgesIgnoringSafeArea(.all
        )
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
