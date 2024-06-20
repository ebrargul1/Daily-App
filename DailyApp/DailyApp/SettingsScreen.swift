//
//  OtherScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//

import SwiftUI

struct SettingsScreen: View {
    
    @EnvironmentObject var settings: SettingsViewModel
    @State private var themeType = AppUserDefaults.preferredTheme
    
    let colors: [UIColor] = [  .systemPink,
                               .systemPurple,
                               .systemTeal,
                               .systemBlue,
                               .systemGreen,
                               .systemRed,
                               .systemBrown,
                               .systemOrange,
                               .systemIndigo
    ]
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("preferences")){
                    HStack{
                        Text("app_theme")
                        Spacer()
                        CustomColorPicker(colors: colors){ color in
                            settings.changeAppcolor(color: color)
                        }
                        
                        
                    }
                }
                
                HStack{
                    Text("appearance")
                    Spacer()
                    Picker("", selection: $themeType.onChange(themeChange)) {
                        Text("default_appearance").tag(0)
                        Text("light_appearance").tag(1)
                        Text("dark_appearance").tag(2)
                    }.fixedSize()
                    
                }
            }.navigationTitle("other_tab")
        }
    }
    
    func themeChange(_ tag : Int) {
        settings.changeAppTheme(theme: tag)
    }
}
