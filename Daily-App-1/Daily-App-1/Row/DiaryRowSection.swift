//
//  DiaryRowSection.swift
//  Daily-App-1
//
//  Created by Ebrar Gül on 26.06.2024.
//

import SwiftUI


struct DiaryRowSection: View {
    var sectionName: String
    var body: some View {
        HStack{
            Spacer()
            Text(sectionName).font(.subheadline).bold()
            Spacer()
        }.padding(4)
            .foregroundColor(Color.primary)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(4)
            .padding(.horizontal)
    }
}
