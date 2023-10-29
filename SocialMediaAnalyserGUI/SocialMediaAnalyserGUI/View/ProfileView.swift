//
//  SwiftUIView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 28/10/2023.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) var ctx
    @Bindable var loggedInUser: LoggedInUser
    @State private var isShowingEditProfileSheet = false
    
    private let width: CGFloat = 100
    
    var body: some View {
        List {
            Section {
                UserDetailsView(firstName: loggedInUser.firstName, lastName: loggedInUser.lastName, username: loggedInUser.username)
            }
            Section("Details") {
                HStack {
                    Text("First Name").frame(width: width, alignment: .leading)
                    Text(loggedInUser.firstName).opacity(0.5)
                }
                HStack {
                    Text("Last Name").frame(width: width, alignment: .leading)
                    Text(loggedInUser.lastName).opacity(0.5)
                }
                HStack {
                    Text("Username").frame(width: width, alignment: .leading)
                    Text(loggedInUser.username).opacity(0.5)
                }
            }
            Section {
                Button("Update Profile") {
                    isShowingEditProfileSheet = true
                }
            }
            Section {
                Button("Logout") {
                    ctx.delete(loggedInUser)
                }.foregroundColor(.red)
            }
        }
        .sheet(isPresented: $isShowingEditProfileSheet) {
            ProfileEditorSheet(loggedInUser: loggedInUser)
        }
    }
}

#Preview {
    ProfileView(loggedInUser: LoggedInUser(username: "username", firstName: "fname", lastName: "lname", isVIP: false, isAdmin: false))
}

struct ProfileEditorSheet: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    private let width: CGFloat = 100
    
    let loggedInUser: LoggedInUser?
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("First Name", text: $firstName)
                } label: {
                    Text("First Name").frame(width: width, alignment: .leading)
                }
                LabeledContent {
                    TextField("Last Name", text: $lastName)
                } label: {
                    Text("Last Name").frame(width: width, alignment: .leading)
                }
                LabeledContent {
                    TextField("Username", text: $username)
                } label: {
                    Text("Username").frame(width: width, alignment: .leading)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Edit Profile")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // TODO: validate data
                        // ...
                        // ...
                        save()
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let loggedInUser {
                username = loggedInUser.username
                firstName = loggedInUser.firstName
                lastName = loggedInUser.lastName
            }
        }
    }
    
    private func save() {
        if let loggedInUser {
            loggedInUser.username = username
            loggedInUser.firstName = firstName
            loggedInUser.lastName = lastName
            let getUser = FetchDescriptor<User>(
                predicate: #Predicate {$0.username == username}
            )
            if let result = try? ctx.fetch(getUser) {
                if result.count == 1 {
                    result[0].username = username
                    result[0].firstName = firstName
                    result[0].lastName = lastName
                }
            }
        }
    }
}
