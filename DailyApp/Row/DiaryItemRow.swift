//
//  DiaryItemRow.swift
//  DailyApp
//
//  Created by Ebrar Gül on 18.06.2024.
//

import SwiftUI

struct DiaryItemRow: View {
    var item: Item
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
                Text(item.title ?? "").font(.headline)
                Text(item.detail ?? "").foregroundColor(.secondary).lineLimit(2)

            }
         
            }
        }
    }
    
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

