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
    var isVIP: Bool
    var isAdmin: Bool
    
    init(username: String, firstName: String, lastName: String, isVIP: Bool, isAdmin: Bool) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.isVIP = isVIP
        self.isAdmin = isAdmin
    }
}
