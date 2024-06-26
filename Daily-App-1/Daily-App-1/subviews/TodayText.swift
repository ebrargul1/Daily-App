//
//  CenterText.swift
//  DailyApp
//
//  Created by Ebrar Gül on 18.06.2024.
//

import SwiftUI

struct TodayText: View {
    
    @Binding var date: Date
    var foregroundColor: Color
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()


    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "calendar")
            Text("\(date, formatter: dateFormatter)")
            Spacer()
        }.foregroundColor(foregroundColor)
    }
}

