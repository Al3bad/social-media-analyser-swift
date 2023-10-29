//
//  LoginView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 28/10/2023.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) var ctx
    private let width: CGFloat = 100
    @State private var showingAlert = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // form fields
                Form {
                    Section(header: Text("Login")) {
                        LabeledContent {
                            TextField("Username", text: $username)
                        } label: {
                            Text("Username").frame(width: width, alignment: .leading)
                        }
                        LabeledContent {
                            SecureField("Password", text: $password)
                        } label: {
                            Text("Password").frame(width: width, alignment: .leading)
                        }
                    }
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    // Login button
                    Section {
                        Button ("Login") {
                            // TODO: validate form
                            // ...
                            
                            // login
                            let predicate = #Predicate<User> { $0.username == username && $0.password == password }
                            do {
                                let user = try ctx.fetch(FetchDescriptor<User>(predicate: predicate))
                                if user.count == 1 {
                                    let loggedinUser = LoggedInUser(username: user[0].username,
                                                                    firstName: user[0].firstName,
                                                                    lastName: user[0].lastName,
                                                                    isVIP: user[0].isVIP,
                                                                    isAdmin: user[0].isAdmin)
                                    ctx.insert(loggedinUser)
                                }
                            } catch {
                                print("Invalid username or password!")
                            }
                        }
                    }
                    // Signup button
                    Section {
                        Button ("Signup") {
                            // TODO: ...
                            showingAlert = true
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("TODO"), message: Text("Has not been implemented!"), dismissButton: .default(Text("Close")))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
