//
//  SettingsViewModel.swift
//  DailyApp
//
//  Created by Ebrar Gül on 19.06.2024.
//

import Foundation
import SwiftUI

class SettingsViewModel : ObservableObject {
    @Published var theme : ColorScheme? = nil
    @Published var appThemeColor : Color = Color.appTheme
    
    init() {
        theme = getTheme()
    }
    
    func getTheme() -> ColorScheme?{
        let theme = AppUserDefaults.preferredTheme
        var _theme : ColorScheme? = nil
        if theme == 0{
            _theme = nil
        } else if theme == 1{
            _theme = ColorScheme.light
        } else {
            _theme = ColorScheme.dark
        }
        return _theme
    }
    
    func changeAppTheme( theme : Int){
        AppUserDefaults.preferredTheme = theme
        self.theme = getTheme()
    }
    
    func changeAppcolor( color : Color){
        let hex = color.uicolor().toHexString()
        if hex.count == 7 {
            AppUserDefaults.appThemeColor = hex
        }
        appThemeColor = Color.appTheme
    }
}
