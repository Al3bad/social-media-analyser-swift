//
//  LoggedInUser.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 29/10/2023.
//

import Foundation
import SwiftData

@Model
class LoggedInUser {
    @Attribute(.unique) var username: String
    var firstName: String
    var lastName: String
    var password: String
    
    init(username: String, firstName: String, lastName: String, password: String) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}
