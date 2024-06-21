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
    @State private var webViewAction = false
    
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
    
    private let productURL = URL(string:"")
    
    @State private var _url = ""
    @State private var _title = ""

    
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
                
                Section(header: Text("feedback".localized())){
                    Button(action: {
                        self.writeReview()
                    }) {
                        HStack {
                            Text("🌟")
                            Text("rate_us".localized()).foregroundColor(.primary)
                            Spacer()
                            Image(systemName:
                                    "chevron.right").imageScale(.small)
                                .foregroundColor(Color(UIColor.systemGray2))
                        }
                    }
                    
                   Button(action: {
                     //  self.$_url = GoogleFormLinks.sendFeedback
                      // self.$_title = "send_feedback".localized()
                      // self.$webViewAction = true
                   }){
                       Text("send_feedback".localized()).foregroundColor(.primary)
                   }.sheet(isPresented: $webViewAction,
                           content: {
                        WebViewWithNavigationUIView(url: self.$_url, title: self.$_title)
                           })
                    
                    
                }
                
                
            }.navigationTitle("other_tab")
        }
    }
    
    func themeChange(_ tag : Int) {
        settings.changeAppTheme(theme: tag)
    }
    
    private func writeReview(){
        var components = URLComponents(url: productURL!, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write_review")
        ]
        guard let writeReviewURL = components?.url else {
            return
        }
        UIApplication.shared.open(writeReviewURL)
    }
}
