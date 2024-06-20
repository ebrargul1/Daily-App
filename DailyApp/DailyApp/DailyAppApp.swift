//
//  DailyAppApp.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//

import SwiftUI

@main
struct DailyAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var alertViewModel = AlertViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()


    var body: some Scene {
        WindowGroup {
            TabScreen()
                .preferredColorScheme(settingsViewModel.theme)
                .environmentObject(alertViewModel)
                .environmentObject(settingsViewModel)
                .accentColor(settingsViewModel.appThemeColor)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
