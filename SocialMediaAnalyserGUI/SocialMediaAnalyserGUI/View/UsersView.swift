//
//  UsersView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 1/11/2023.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var ctx
    
    @State private var showingAlert = false
    
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text("\(user.firstName) \(user.lastName) (\(user.username))")
                    .foregroundStyle(.red)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            if user.isAdmin {
                                showingAlert = true
                            } else {
                                ctx.delete(user)
                            }
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Action Not Allowed"), message: Text("Admin user cannot be deleted!"), dismissButton: .default(Text("Ok")))
                    }
            }
        }
    }
}

#Preview {
    UsersView()
}
