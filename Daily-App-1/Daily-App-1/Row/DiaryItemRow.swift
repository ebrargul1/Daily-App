//
//  DiaryItemRow.swift
//  DailyApp
//
//  Created by Ebrar Gül on 18.06.2024.
//

import SwiftUI

struct DiaryItemRow: View {
    var item: Item
    var itemFormatter: DateFormatter
    var dateBackgraundColor: Color
    var body: some View {

        HStack{
            Text("\(item.timestamp!, formatter: itemFormatter)")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(8)
                .background(dateBackgraundColor)
                .cornerRadius(8)
            
            Text(item.emoji ?? "").font(.title)
            VStack(alignment: .leading){
                Text(item.title ?? "").font(.headline).foregroundColor(.primary)
                Text(item.detail ?? "").foregroundColor(.secondary).lineLimit(2)

            }
            Spacer()
            Image.init(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(Color(UIColor.systemGray3))
                .padding(8)
            }
        }
    }
    

