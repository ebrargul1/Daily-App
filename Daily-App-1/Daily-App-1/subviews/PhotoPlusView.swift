//
//  PhotoPlusView.swift
//  Daily-App-1
//
//  Created by Ebrar Gül on 26.06.2024.
//

import SwiftUI

struct PhotoPlusView: View {
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image.init(systemName: "photo")
                .imageScale(.large)
                .foregroundColor(.secondary)
              
        }
    }
}

#Preview {
    PhotoPlusView()
}
