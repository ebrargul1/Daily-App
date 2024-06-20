//
//  AddDiaryScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//

import SwiftUI
import Localize_Swift
import OmenTextField

struct AddDiaryScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var alertViewModel : AlertViewModel

    
    @State var title: String = ""
    @State var description: String = ""
    @State var emoji: String = ""
    @State var showEmojiView: Bool = false
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd\nMM"
        return formatter
    }()

    
    var body: some View {
        Form{
            Section{
                TodayText ()
            }
           
            TextField("diary_title".localized(), text: $title)
            OmenTextField("diary_description".localized(), text: $description)
            Button {
                self.showEmojiView = true
            } label: {
                EmojiLabelView(emoji: $emoji)
            }.sheet(isPresented: $showEmojiView, content: {
                EmojiView(txt: $emoji)
            })
            
            

        }.navigationBarItems(trailing:
        Button(action: {
            if title.isEmpty {
                self.alertViewModel.showAlert(title: "empty_title_alert".localized(), message: "empty_title_alert_message".localized())
            }
            else{
                addItem()
                presentationMode.wrappedValue.dismiss()}
            
        }, label: {
            Image(systemName: "plus.square")
        })
            .alert(isPresented: $alertViewModel.showAlert){
                            Alert(title: Text(alertViewModel.title),
                                       message: Text(alertViewModel.message))
                        }
            
        
        
        
        ).navigationTitle(Text("add_diary".localized()))
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = title
            newItem.detail = description
            newItem.emoji = emoji

            do {
                try viewContext.save()
            } catch {
              
                let nsError = error as NSError
                debugPrint(nsError.localizedDescription)
            }
        }
    }
}

