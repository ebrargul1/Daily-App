//
//  EmojiLabelView.swift
//  DailyApp
//
//  Created by Ebrar Gül on 24.05.2024.
//

import SwiftUI
struct EmojiLabelView : View {
    @Binding var emoji : String
    var body: some View {
        HStack{
            Text("select_emoji")
                .foregroundColor(.primary)
            Spacer()
            Text(self.emoji)
                .font(.title)
            if self.emoji.isEmpty{
                Text("🥰🤩😤").font(.subheadline)
            }
            Image(systemName:
                    "chevron.right").imageScale(.small).foregroundColor(.gray)
        }
    }
}
