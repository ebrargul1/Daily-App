//
//  CustomColorPicker.swift
//  DailyApp
//
//  Created by Ebrar Gül on 18.06.2024.
//

import Foundation
import SwiftUI

struct CustomColorPicker: View {
    
    @State var colors:[UIColor]
    
    var completion: (Color) -> ()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 20){
                ForEach(0..<colors.count){ index in
                    ZStack(alignment: .center){
                        Button(action: {
                            self.completion(Color(self.colors[index]))
                        }){
                            Circle()
                                .fill(Color(self.colors[index]))
                                    .frame(width: 30, height: 30, alignment: .center)
                        }
                    }.frame(width: 36, height: 36, alignment: .center)
                }
            }.padding(8)
        }
    }
}
