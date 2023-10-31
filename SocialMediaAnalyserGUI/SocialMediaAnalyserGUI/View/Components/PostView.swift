//
//  PostView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import SwiftUI

struct PostView: View {
    private let spacing = 4.0
    private let opacity = 0.5
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            HStack {
                HStack (spacing: spacing) {
                    Image(systemName: "person.fill")
                    Text("@\(post.author ?? "")")
                }.opacity(opacity)
                Spacer()
            }
            Text(post.content ?? "").opacity(0.8)
            HStack (spacing: 16) {
                HStack (spacing: spacing) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .shadow(color: .red, radius: 6.0)
                    Text("\(post.likes!)")
                }.opacity(opacity)
                HStack (spacing: spacing) {
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .foregroundColor(.cyan)
                        .shadow(color: .cyan, radius: 6.0)
                    Text("\(post.shares!)")
                }.opacity(opacity)
                Spacer()
                HStack (spacing: spacing) {
                    Image(systemName: "calendar")
                    Text(post.dateTime ?? "")
                }.opacity(opacity)
            }
        }
        .font(.system(size: 12))
    }
}

#Preview {
    PostView(post: Post(author: "xv", likes: 10, shares: 42, dateTime: "10/10/2012", content: "Hello World!"))
}
