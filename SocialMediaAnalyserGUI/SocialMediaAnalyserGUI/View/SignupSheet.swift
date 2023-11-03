//
//  SignupView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 3/11/2023.
//

import SwiftUI
import SwiftData

struct SignupView: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var vm = SignupFormViewModel()
    @FocusState private var focusedField: Field?
    
    @State private var errorMessages = ""
    
    private let width: CGFloat = 100
    private var title = "Create New User"
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Signup"), footer: Group {
                    if !errorMessages.isEmpty {
                        Text(errorMessages).foregroundStyle(.red)
                    }
                }) {
                    username
                    firstName
                    lastName
                    password
                }
                .autocorrectionDisabled()
                .autocapitalization(.none)
                // Signup button
                Section {
                    Button ("Signup") {
                        signup()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Signup") {
                        signup()
                    }
                }
            }
        }
    }
    
    func signup() {
        focusedField = nil
        do {
            try vm.create(context: ctx)
        } catch ParseError.form(let messages) {
            errorMessages = ""
            for msg in messages {
                errorMessages += "\(msg)\n"
            }
        } catch {}
    }
}

#Preview {
    SignupView()
}

extension SignupView {
    enum Field: Hashable {
        case username
        case firstName
        case lastName
        case password
    }
}

extension SignupView {
    var username: some View {
        LabeledContent {
            TextField("Username", text: $vm.user.username)
                .focused($focusedField, equals: .username)
        } label: {
            Text("Username").frame(width: width, alignment: .leading)
        }
    }
    var firstName: some View {
        LabeledContent {
            TextField("First Name", text: $vm.user.firstName)
                .focused($focusedField, equals: .firstName)
        } label: {
            Text("First Name").frame(width: width, alignment: .leading)
        }
    }
    var lastName: some View {
        LabeledContent {
            TextField("Last Name", text: $vm.user.lastName)
                .focused($focusedField, equals: .lastName)
        } label: {
            Text("Last Name").frame(width: width, alignment: .leading)
        }
    }
    var password: some View {
        LabeledContent {
            SecureField("Password", text: $vm.user.password)
                .focused($focusedField, equals: .password)
        } label: {
            Text("Password").frame(width: width, alignment: .leading)
        }
    }
}
