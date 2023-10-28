//
//  PostView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import SwiftUI

struct PostView: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            HStack {
                Label(post.author, systemImage: "person.fill")
                Spacer()
                Label(String(post.id), systemImage: "number.circle.fill")
            }
            Text(post.content)
            HStack {
                Label(String(post.likes), systemImage: "heart.fill")
                Label(String(post.shares), systemImage: "arrowshape.turn.up.right.circle.fill")
                Spacer()
                Label(post.dateTime, systemImage: "calendar")
            }
        }
    }
}

#Preview {
    PostView(post: Post(id: 10, author: "xv", likes: 10, shares: 42, dateTime: "10/10/2012", content: "Hello World!"))
}
