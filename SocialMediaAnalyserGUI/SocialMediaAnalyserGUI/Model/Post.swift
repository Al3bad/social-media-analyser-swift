//
//  Post.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 27/10/2023.
//

import Foundation

struct Post:CustomStringConvertible, Identifiable {
    var id: Int
    var author: String
    var likes: Int
    var shares: Int
    var dateTime: String
    var content: String

    var description: String {
        return "\(id),\(author),\(likes),\(shares),\(dateTime),\(content)"
    }
}
