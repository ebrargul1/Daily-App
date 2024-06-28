//
//  Daily_App_1App.swift
//  Daily-App-1
//
//  Created by beyzanur cayrat on 25.06.2024.
//

import SwiftUI


@main
struct Daily_App_1App: App {
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
