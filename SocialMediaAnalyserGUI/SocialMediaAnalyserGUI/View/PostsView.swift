//
//  GetPostsView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 29/10/2023.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case likes
    case shares
}

struct PostsView: View {
    @State private var isShowingPostEditorSheet = false
    @State private var sortedByLikes = true
    @State private var postToEdit: Post?
    @State private var searchQuery = ""
    @State private var selectedSortOption = SortOption.allCases.first!
    
    @Query var posts: [Post]
    
    var filteredPosts: [Post] {
        if searchQuery.isEmpty {
            return posts.sort(on: selectedSortOption)
        }
        
        return posts.compactMap { post in
            let autherContainsQuery = post.author.range(of: searchQuery, options: .caseInsensitive) != nil
            return autherContainsQuery ? post : nil
        }.sort(on: selectedSortOption)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPosts) { post in
                Section {
                    PostView(post: post)
                        .onTapGesture {
                            postToEdit = post
                        }
                }
            }
            .toolbar {
                ToolbarItemGroup (placement: .topBarLeading) {
                    Button("Add", systemImage: "plus") {
                        isShowingPostEditorSheet = true
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Picker("", selection: $selectedSortOption) {
                            ForEach(SortOption.allCases, id: \.rawValue) { option in
                                Text(option.rawValue.capitalized).tag(option)
                            }
                        }
                        .labelsHidden()
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .animation(.easeIn, value: filteredPosts)
        .searchable(text: $searchQuery, prompt: "Search posts by an author")
        .sheet(isPresented: $isShowingPostEditorSheet) {
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

private extension [Post] {
    func sort(on option: SortOption) -> [Post] {
        switch option {
        case .likes:
            self.sorted(by: { $0.likes > $1.likes })
        case .shares:
            self.sorted(by: { $0.shares > $1.shares })
        }
    }
}
