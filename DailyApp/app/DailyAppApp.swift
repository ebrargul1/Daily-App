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
    @StateObject var dialogAlertViewModel = DialogAlertViewModel()



    var body: some Scene {
        WindowGroup {
            TabScreen()
                .preferredColorScheme(settingsViewModel.theme)
                .environmentObject(alertViewModel)
                .environmentObject(settingsViewModel)
                .environmentObject(dialogAlertViewModel)
                .accentColor(settingsViewModel.appThemeColor)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .alert(isPresented: $dialogAlertViewModel.showingAlert) {
                    Alert(title: Text(self.dialogAlertViewModel.title),
                        message: Text(self.dialogAlertViewModel.message),
                          primaryButton: .destructive(Text(self.dialogAlertViewModel.okTitle)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.dialogAlertViewModel.onClicked()
                        }
                    },
                          secondaryButton: .cancel())
                }
        }
    }
}
