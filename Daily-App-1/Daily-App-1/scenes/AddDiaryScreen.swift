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
    @EnvironmentObject var alertViewModel: AlertViewModel
    @EnvironmentObject var dialogAlertViewModel: DialogAlertViewModel

    @State var date = Date()
    @State var title: String = ""
    @State var description: String = ""
    @State var emoji: String = ""
    @State var showEmojiView: Bool = false
    @Binding var item: Item?

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd\nMM"
        return formatter
    }()

    var body: some View {
        Form {
            Section {
                DatePicker("select_date", selection: $date, in: ...Date(), displayedComponents: .date)
            }

            TextField("diary_title".localized(), text: $title)

            OmenTextField("diary_description".localized(), text: $description)

            Button {
                self.showEmojiView = true
            } label: {
                EmojiLabelView(emoji: $emoji)
            }.sheet(isPresented: $showEmojiView) {
                EmojiView(txt: $emoji)
            }

            Section {
                ZStack {
                    Color.appTheme.opacity(0.25).edgesIgnoringSafeArea(.all)
                    Button {
                        if title.isEmpty {
                            self.alertViewModel.showAlert(title: "empty_title_alert".localized(), message: "empty_title_alert_message".localized())
                        } else {
                            saveItem()
                            goBack()
                        }
                    } label: {
                        Text("save").bold()
                            .foregroundColor(.appTheme)
                            .frame(maxWidth: .infinity)
                    }
                    .alert(isPresented: $alertViewModel.showAlert) {
                        Alert(title: Text(alertViewModel.title),
                              message: Text(alertViewModel.message),
                              dismissButton: .default(Text(alertViewModel.defaultButtonTitle)))
                    }
                }
            }.listRowInsets(EdgeInsets())
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let _item = item {
                    self.emoji = _item.emoji ?? ""
                    self.description = _item.detail ?? ""
                    self.title = _item.title ?? ""
                    self.date = _item.timestamp ?? Date()
                }
            }
        }
        .navigationBarItems(trailing:
            HStack {
                Button {
                    // PhotoPlusView action
                } label: {
                    PhotoPlusView()
                }

                Button(action: {
                    self.dialogAlertViewModel.showAlert(title: "are_you_sure_want_to_delete".localized(),
                                                        yesTitle: "delete",
                                                        dismissTitle: "cancel".localized(),
                                                        okTitle: "delete".localized()) {
                        if let _item = item {
                            viewContext.delete(_item)
                        }
                        goBack()
                    }
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(item == nil ? Color.gray : Color.red)
                }).disabled(item == nil)
            }
        )
        .navigationTitle(Text("add_diary".localized()))
    }

    private func goBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            presentationMode.wrappedValue.dismiss()
        }
    }

    private func saveItem() {
        var newItem: Item
        if let _item = item {
            newItem = _item
        } else {
            newItem = Item(context: viewContext)
        }

        withAnimation {
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
