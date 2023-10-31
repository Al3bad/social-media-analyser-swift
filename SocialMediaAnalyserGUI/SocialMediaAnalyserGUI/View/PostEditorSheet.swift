//
//  PostEditor.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 31/10/2023.
//

import SwiftUI

struct PostEditorSheet: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var vm = PostEditorViewModel()
    @FocusState private var focusedField: Field?
    
    @State private var errorMessages = ""
    
    let post: Post?
    
    private let width: CGFloat = 100
    private var editorTitle: String {
        post == nil ? "Add Post" : "Edit Post"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    author
                    likes
                    shares
                    content
                } footer: {
                    if !errorMessages.isEmpty {
                        Text(errorMessages).foregroundStyle(.red)
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
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        focusedField = nil
                        do {
                            if let post {
                                try vm.update(post: post)
                            } else {
                                try vm.create(context: ctx)
                            }
                            dismiss()
                        } catch ParseError.form(let messages) {
                            errorMessages = ""
                            for msg in messages {
                                errorMessages += "\(msg)\n"
                            }
                        } catch {}
                    }
                }
            }
        }
        .onAppear {
            if let post {
                vm.post.author  = post.author!
                vm.post.likes   = String(post.likes!)
                vm.post.shares  = String(post.shares!)
                vm.post.content = post.content!
            }
        }
    }
}

#Preview {
    PostEditorSheet(post: nil)
}

extension PostEditorSheet {
    enum Field: Hashable {
        case author
        case likes
        case shares
        case dateTime
        case content
    }
}

extension PostEditorSheet {
    var author: some View {
        LabeledContent {
            TextField("Author", text: $vm.post.author).focused($focusedField, equals: .author)
        } label: {
            Text("Author").frame(width: width, alignment: .leading)
        }
    }
    var likes: some View {
        LabeledContent {
            TextField("Likes", text: $vm.post.likes).focused($focusedField, equals: .likes)
        } label: {
            Text("Likes").frame(width: width, alignment: .leading)
        }
    }
    var shares: some View {
        LabeledContent {
            TextField("Shares", text: $vm.post.shares).focused($focusedField, equals: .shares)
        } label: {
            Text("Shares").frame(width: width, alignment: .leading)
        }
    }
    var content: some View {
        LabeledContent {
            TextField("Content", text: $vm.post.content).focused($focusedField, equals: .content)
        } label: {
            Text("Content").frame(width: width, alignment: .leading)
        }
    }
}
