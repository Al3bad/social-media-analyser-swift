//
//  GetPostsView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 29/10/2023.
//

import SwiftUI
import SwiftData

struct PostsView: View {
    @State private var isShowingEditProfileSheet = false
    @State private var postToEdit: Post?
    
    @Query var posts: [Post]
    
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                Section {
                    PostView(post: post)
                        .onTapGesture {
                            postToEdit = post
                        }
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    Button("Add", systemImage: "plus") {
                        isShowingEditProfileSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingEditProfileSheet) {
            PostEditorSheet(post: nil)
        }
        .sheet(item: $postToEdit) { post in
            PostEditorSheet(post: post)
        }
        
    }
}

#Preview {
    PostsView()
}

struct PostEditorSheet: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) private var dismiss
    let post: Post?
    
    @State private var author = ""
    @State private var likes = ""
    @State private var shares = ""
    @State private var dateTime = Date()
    @State private var content = ""
    
    private let width: CGFloat = 100
    private var editorTitle: String {
        post == nil ? "Add Post" : "Edit Post"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("Author", text: $author)
                } label: {
                    Text("Author").frame(width: width, alignment: .leading)
                }
                LabeledContent {
                    TextField("Likes", text: $likes)
                } label: {
                    Text("Likes").frame(width: width, alignment: .leading)
                }
                LabeledContent {
                    TextField("Shares", text: $shares)
                } label: {
                    Text("Shares").frame(width: width, alignment: .leading)
                }
                LabeledContent {
                    TextField("Content", text: $content)
                } label: {
                    Text("Content").frame(width: width, alignment: .leading)
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
            if let post {
                author  = post.author
                likes   = String(post.likes)
                shares  = String(post.shares)
                content = post.content
            }
        }
    }
    
    private func save() {
        if let post {
            post.author  = author
            post.likes   = Int(likes) ?? 0
            post.shares  = Int(shares) ?? 0
            post.content = content
        } else {
            let newPost = Post(author: author, likes: Int(likes) ?? 0, shares: Int(shares) ?? 0, dateTime: "", content: content)
            ctx.insert(newPost)
        }
    }
}
