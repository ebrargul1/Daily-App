//
//  ListViewModel.swift
//  DailyApp
//
//  Created by Ebrar Gül on 20.06.2024.
//

import Foundation

class ListViewModel : ObservableObject {
    
    @Published var items: [Item] = []
    
    func onAppear(){
        getItems(searchText: "")
    }
    
    func getItems(searchText: String){
        PersistenceController.shared.getByItems(query: searchText){ items in
            self.items = items
        }
    }
}
