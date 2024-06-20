//
//  ListScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//

import SwiftUI

struct ListScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var settings: SettingsViewModel
    
    @ObservedObject var viewModel = ListViewModel()
    
    @State var actionAddDiary : Int? = 0
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                
                NavigationLink( destination: AddDiaryScreen(), tag: 1, selection: $actionAddDiary) {
                    EmptyView()
                }
                List{
                    ForEach(viewModel.items) { item in
                        NavigationLink(destination: DetailScreen.init(item: item)) {
                            DiaryItemRow(item: item,
                                         dateBackgraundColor: settings.appThemeColor)
                        }
                       
                    }
                    }.onAppear(perform: {
                    viewModel.getItems(searchText: searchText)
                    })
                    .searchable(text: $searchText, prompt: "search_bar_placeholder".localized())
                    .onChange(of: searchText){ newValue in
                        viewModel.getItems(searchText: newValue)
                    }
                
                Button{
                    self.actionAddDiary = 1
                } label: {
                    FabButtonView(color: settings.appThemeColor)
                        .padding(24)
                }
            }
            .navigationTitle(Text("list_tab"))
            
        }
        
      
        }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd \n MMM"

        return formatter
    }()
}


