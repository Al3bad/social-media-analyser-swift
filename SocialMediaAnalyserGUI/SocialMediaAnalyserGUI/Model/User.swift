//
//  User.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var username: String
    var firstName: String
    var lastName: String
    var password: String
    var isVIP: Bool = false
    var isAdmin: Bool = false
    
    init(username: String, firstName: String, lastName: String, password: String) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}
