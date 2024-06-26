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
    @EnvironmentObject var dialogAlertViewModel: DialogAlertViewModel

    
    @ObservedObject var viewModel = ListViewModel()
    
    @State var actionAddDiary : Int? = 0
    @State private var searchText = ""
    @State private var item: Item? = nil
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                
                NavigationLink( destination: AddDiaryScreen( item: $item), tag: 1, selection: $actionAddDiary) {
                    EmptyView()
                }
                List{
                    ForEach(viewModel.items) { item in
                       
                        Button.init{
                            self.item = item
                            self.actionAddDiary = 1
                        } label: {
                            DiaryItemRow(item: item,
                                         itemFormatter: itemFormatter,
                                         dateBackgraundColor: settings.appThemeColor)
                        }
                        
                    }.onDelete(perform: deleteItems)
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
    
    private func deleteItems(offsets: IndexSet){
        self.dialogAlertViewModel.showAlert(title: "are_you_sure_want_to_delete".localized(),
                                      yesTitle: "delete".localized(),
                                      dismissTitle: "cancel".localized(),
                                      okTitle: "ok".localized()
        ){
            withAnimation {
                offsets.map { viewModel.items[$0] }.forEach(viewContext.delete)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    debugPrint("nsError when deleting => \(nsError)")
                }
                viewModel.getItems(searchText: searchText)
            }
        }
        
    }

    
    
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd\nMMM"
        return formatter
    }()
}


