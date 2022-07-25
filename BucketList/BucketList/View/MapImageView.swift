//
//  MapImageView.swift
//  BucketList
//
//  Created by Félix Tineo Ortega on 25/07/2022.
//

import SwiftUI

struct MapImageView: View {
    var body: some View {
        Image("map")
            .resizable()
            .opacity(0.1)
            .blur(radius: 3)
    }
}

struct MapImageView_Previews: PreviewProvider {
    static var previews: some View {
        MapImageView()
    }
}
