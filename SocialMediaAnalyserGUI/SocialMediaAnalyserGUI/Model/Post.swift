//
//  Post.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import Foundation
import SwiftData

@Model
class Post: CustomStringConvertible {
    var author: String?
    var likes: Int?
    var shares: Int?
    var dateTime: String?
    var content: String?
    
    init() {}
    
    init(author: String, likes: Int, shares: Int, dateTime: String, content: String) {
        self.author = author
        self.likes = likes
        self.shares = shares
        self.dateTime = dateTime
        self.content = content
    }

    var description: String {
        return "\(UInt(self.hashValue) as UInt),\(author!),\(likes!),\(shares!),\(dateTime!),\(content!)"
    }
}
