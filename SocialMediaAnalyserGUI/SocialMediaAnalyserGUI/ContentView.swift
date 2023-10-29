//
//  ContentView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var ctx
    @Query var user: [LoggedInUser]
    
    var body: some View {
        Group {
            if user.count > 0 {
                TabView {
                    DashboardView(loggedInUser: user[0])
                        .tabItem {
                            Label("Dashboard", systemImage: "gauge.open.with.lines.needle.33percent")
                        }
                    PostsView()
                        .tabItem {
                            Label("Posts", systemImage: "doc.fill")
                        }
                    ProfileView(loggedInUser: user[0])
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Create admin user by default
            let predicate = #Predicate<User> { $0.username == "admin"}
            do {
                let results = try ctx.fetch(FetchDescriptor<User>(predicate: predicate))
                if results.count == 0 {
                    let adminUser = User(username: "admin", firstName: "fname", lastName: "lname", password: "admin")
                    adminUser.isAdmin = true
                    ctx.insert(adminUser)
                } else {
                    print(results[0])
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
