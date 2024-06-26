import SwiftUI

struct EmojiView: View {
    
    @Binding var txt: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(getEmojiList(), id: \.self) { row in
                            HStack(spacing: 25) {
                                ForEach(row, id: \.self) { codePoint in
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                        self.txt = String(UnicodeScalar(codePoint)!)
                                    }) {
                                        if let unicodeScalar = UnicodeScalar(codePoint),
                                           unicodeScalar.properties.isEmoji {
                                            Text(String(unicodeScalar))
                                                .font(.system(size: 36))
                                        } else {
                                            Text("")
                                        }
                                    }
                                }
                            }
                        }
                    }.padding(.top)
                }
            }
            .navigationTitle("select_emoji")
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark").foregroundColor(.gray)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getEmojiList() -> [[Int]] {
        var emojis: [[Int]] = []
        
        for i in stride(from: 0x1F601, through: 0x1F64F, by: 4) {
            var temp: [Int] = []
            for j in i..<i+4 {
                temp.append(j)
            }
            emojis.append(temp)
        }
        
        return emojis
    }
}

struct EmojiView_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        EmojiView(txt: $text)
    }
}
