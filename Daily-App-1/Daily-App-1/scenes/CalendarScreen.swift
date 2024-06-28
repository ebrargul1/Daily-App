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
    
    @State var actionInput: Int? = 0
    @State var item: Item? = nil

    var body: some View {
        NavigationView{
            
            ZStack{
                Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
                NavigationLink(destination: AddDiaryScreen(item: $item), tag:1, selection: $actionInput) {
                    EmptyView()
                }
                
                CalendarView(appThemeColor: $settings.appThemeColor,
                             item: $item,
                             actionInput: $actionInput,
                             items: $viewModel.items)
                
                
            }.onAppear(perform: viewModel.onAppear)
                .navigationTitle(Text("calendar_tab"))
               
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CalendarScreen()
}
