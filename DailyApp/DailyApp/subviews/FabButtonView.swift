//
//  FabButtonView.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//
import SwiftUI

struct FabButtonView: View {
    var color: Color = .blue
    
    var body: some View {
        Text("+")
            .foregroundColor(.white)
            .font(.title)
            .padding()
            .background(color)
            .clipShape(Circle()) 
    }
}

struct FabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FabButtonView()
    }
}
