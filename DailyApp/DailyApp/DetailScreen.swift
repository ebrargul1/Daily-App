//
//  DetailScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 18.06.2024.
//

import SwiftUI

struct DetailScreen: View {
    var item: Item
    var body: some View {
        Text(item.title ?? "" )
    }
}

