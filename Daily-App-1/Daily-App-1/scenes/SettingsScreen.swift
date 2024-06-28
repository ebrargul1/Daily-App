//
//  OtherScreen.swift
//  DailyApp
//
//  Created by Ebrar Gül on 9.05.2024.
//

import SwiftUI

struct SettingsScreen: View {
    
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var dialogAlertViewModel: DialogAlertViewModel
    
    
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
                    
                    HStack{
                        Text("appearance")
                        Spacer()
                        Picker("", selection: $themeType.onChange(themeChange)) {
                            Text("default_appearance").tag(0)
                            Text("light_appearance").tag(1)
                            Text("dark_appearance").tag(2)
                        }.fixedSize()
                        
                    }
                    
                }.alert(isPresented: $settings.alertMessage.isShowing) {
                    Alert(title: Text(""), message: Text(settings.alertMessage.message),
                          dismissButton: .default(Text("ok".localized())))
                }
                  
                    
                    Section(header: Text("feedback".localized())){
                        Button(action: {
                            writeReview()
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
                            self._url = "https://docs.google.com/forms/d/e/1FAIpQLScwq05zxjTX9nr-2xesT_jYqmVHDwhTkxYOx2pnWzAAvRV-5A/viewform?usp=sf_link"
                            self._title = "send_feedback".localized()
                            self.webViewAction = true
                        }){
                            Text("send_feedback".localized()).foregroundColor(.primary)
                        }.sheet(isPresented: $webViewAction,
                                content: {
                            WebViewWithNavigationUIView(url: self.$_url, title: self.$_title)
                        })
                        
                        
                    }
                
                Section(header: Text("developer".localized()), footer:
                                        Text("follow_social_media".localized())) {
                    Button(action: {
                        openTwitter(twitterHandle: "ebrargull16")
                    }){
                        HStack {
                            Image("ic_profile")
                                .clipShape(Circle())
                                .shadow(radius: 1)
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            Text("Ebrar Gül").foregroundColor(.primary)
                            Spacer()
                            Image("ic_twitter")

                            }
                        }
                    }
                }.navigationTitle("other_tab")
            }.navigationViewStyle(StackNavigationViewStyle())
        }
        
        func themeChange(_ tag : Int) {
            settings.changeAppTheme(theme: tag)
        }
        
       func writeReview(){
            var components = URLComponents(url: productURL!, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "action", value: "write_review")
            ]
            guard let writeReviewURL = components?.url else {
                return
            }
            UIApplication.shared.open(writeReviewURL)
        }
    
    func openTwitter(twitterHandle: String) {
        let appURL = URL(string: "https://x.com/ebrargull16_?s=09\(twitterHandle)")!
        let webURL = URL(string: "https://x.com/ebrargull16_?s=09\(twitterHandle)")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL as URL){
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }
    }

