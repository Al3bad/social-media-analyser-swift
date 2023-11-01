//
//  UsersView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 1/11/2023.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text("\(user.firstName) \(user.lastName) (\(user.username))")
            }
        }
    }
}

#Preview {
    UsersView()
}
