//
//  SocialMediaAnalyserGUIApp.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import SwiftUI
import SwiftData

@main
struct SocialMediaAnalyserGUIApp: App {    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self, LoggedInUser.self, Post.self])
        }
    }
}
