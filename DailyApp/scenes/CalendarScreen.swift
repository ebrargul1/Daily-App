//
//  CalendarScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 21.06.2024.
//

import SwiftUI

struct CalendarScreen: View {
    @EnvironmentObject var settings: SettingsViewModel
    @ObservedObject var viewModel = CalendarViewModel()
    
    @State var selectedDate = Date()
    @State var actionInput: Int? = 0
    @State var items: [Item] = []

    var body: some View {
        NavigationView{
            
            ZStack{
                CalendarView(appThemeColor: $settings.appThemeColor,
                             selectedDate: $selectedDate,
                             actionInput: $actionInput,
                             items: $viewModel.items)
            
            
            }.onAppear(perform: viewModel.onAppear)
            .navigationTitle(Text("calendar_tab"))
        }
    }
}

#Preview {
    CalendarScreen()
}
