//
//  HomeView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 28/10/2023.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    var loggedInUser: LoggedInUser
    
    var body: some View {
        VStack {
            UserDetailsView(firstName: loggedInUser.firstName, lastName: loggedInUser.lastName, username: loggedInUser.username).padding(16)
            Divider().padding(.bottom, 32)
            if !loggedInUser.isVIP && !loggedInUser.isAdmin {
                NormalUserView()
            } else if loggedInUser.isVIP && !loggedInUser.isAdmin {
                VIPUserView()
            } else if loggedInUser.isAdmin {
                AdminUserView()
            } else {
                Text("Something wrong happend! User type has not been identified!")
            }
            Spacer()
        }
    }
}

struct NormalUserView: View {
    var body: some View {
        Text("Normal User View")
    }
}

struct VIPUserView: View {
    // TODO: implement VIP user view
    var body: some View {
        Text("VIP User View")
    }
}

struct AdminUserView: View {
    // TODO: implement Admin user view
    var body: some View {
        Text("Admin User View")
    }
}

#Preview {
    DashboardView(loggedInUser: LoggedInUser(username: "username", firstName: "fname", lastName: "lname", isVIP: false, isAdmin: false))
}
