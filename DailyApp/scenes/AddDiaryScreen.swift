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
    
    @State var date = Date()
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
                
                DatePicker( "select_date", selection: $date, in: ...Date(), displayedComponents: .date)
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
            
            Section {
                ZStack {
                    Color.appTheme.opacity(0.25).edgesIgnoringSafeArea(.all)
                    Button {
                        if title.isEmpty {
                            self.alertViewModel.showAlert(title: "empty_title_alert".localized(), message: "empty_title_alert_message".localized())
                        }else{
                            addItem()
                            presentationMode.wrappedValue.dismiss()}
                        
                    } label: {
                        Text("add").bold()
                            .foregroundColor(.appTheme)
                            .frame (maxWidth: .infinity)
                    }
                    .alert(isPresented: $alertViewModel.showAlert){
                        Alert(title: Text(alertViewModel.title),
                              message: Text(alertViewModel.message),
                              dismissButton: .default(Text(alertViewModel.defaultButtonTitle)))
                    }
                }
            }.listRowInsets(EdgeInsets())
        }
        
        .navigationTitle(Text("add_diary".localized()))
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = date
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


