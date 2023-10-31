//
//  CreatePostViewModel.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 31/10/2023.
//

import Foundation
import SwiftData


struct NewPost: Codable {
    var author: String
    var likes: String
    var shares: String
    var content: String
}

extension NewPost {
    static var empty: NewPost {
        return NewPost(author: "", likes: "", shares: "", content: "")
    }
}

final class PostEditorViewModel: ObservableObject  {
    @Published var post: NewPost = .empty
    
    func create(context: ModelContext) throws {
        let newPost = try validate()
        context.insert(newPost)
    }
    
    func update(post: Post) throws {
        let newPost = try validate()
        post.author  = newPost.author!
        post.likes   = Int(newPost.likes!)
        post.shares  = Int(newPost.shares!)
        post.content = newPost.content!
    }
    
    func validate() throws -> Post {
        var isValid = true
        var errors: [String] = []
        
        let newPost = Post()
        
        do {
            try newPost.author =  Parser.parseStr(str: post.author)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("author: " + message)
        } catch {}
        
        do {
            try newPost.likes = Parser.parseInt(str: post.likes, min: 0)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("likes: " + message)
        } catch {}
        
        do {
            try newPost.shares = Parser.parseInt(str: post.shares, min: 0)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("shares: " + message)
        } catch {}
        
        do {
            try newPost.content = Parser.parseStr(str: post.content)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("content: " + message)
        } catch {}
        
        if !isValid {
            throw ParseError.form(messages: errors)
        }
        
        return newPost
    }
}
