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
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image? = nil

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
            
            if let image = image {
                Section {
                    GeometryReader { reader in
                        ZStack {
                            image
                                .resizable()
                                .cornerRadius(8)
                                .padding(.all, 1)
                                .frame(width: reader.size.width ,
                                       height: reader.size.height)
                                .aspectRatio(contentMode: .fill)
                        }
                    }.frame(height: 200)
                }
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
        .onChange(of: inputImage) { _ in loadImage() }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let _item = item {
                    self.emoji = _item.emoji ?? ""
                    self.description = _item.detail ?? ""
                    self.title = _item.title ?? ""
                    self.date = _item.timestamp ?? Date()
                 /*  if let imageData = item?.images?.imageContent {
                        self.inputImage = UIImage(data: imageData)
                        self.image = Image(uiImage: self.inputImage!)
                    }*/
                }
            }
        }
        .navigationBarItems(trailing:
            HStack {
                Button {
                    showingImagePicker = true
                } label: {
                    PhotoPlusView()
                }.sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
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
    
    func loadImage() {
        guard let _inputImage = inputImage else { return }
        image = Image(uiImage: _inputImage)
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
        
       /* if let inputImage = inputImage {
            let dImage = DImage(context: viewContext)
           dImage.origin = newItem
           dImage.imageContent = inputImage.pngData()
            newItem.addToImages(dImage)
        } */

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
