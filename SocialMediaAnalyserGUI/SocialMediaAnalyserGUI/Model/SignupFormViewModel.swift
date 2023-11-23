//
//  SignupFormViewModel.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 3/11/2023.
//

import Foundation
import SwiftData

struct NewUser: Codable {
    var username: String
    var firstName: String
    var lastName: String
    var password: String
}

extension NewUser {
    static var empty: NewUser {
        return NewUser(username: "", firstName: "", lastName: "", password: "")
    }
}

final class SignupFormViewModel: ObservableObject {
    @Published var user: NewUser = .empty
    
    func create(context: ModelContext) throws {
        let newUser = try validate()
        context.insert(newUser)
        context.insert(LoggedInUser(username: newUser.username, firstName: newUser.firstName, lastName: newUser.lastName, isVIP: newUser.isVIP, isAdmin: newUser.isAdmin))
    }
    
    func validate() throws -> User {
        var isValid = true
        var errors: [String] = []
        
        var username = ""
        var firstName = ""
        var lastName = ""
        var password = ""
        
        do {
            username = try Parser.parseStr(str: user.username)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("username: " + message)
        } catch {}
        
        do {
            firstName = try Parser.parseStr(str: user.firstName)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("first name: " + message)
        } catch {}
        
        do {
            lastName = try Parser.parseStr(str: user.lastName)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("last name: " + message)
        } catch {}
        
        do {
            password = try Parser.parseStr(str: user.password)
        } catch ParseError.withMessage(let message) {
            isValid = false
            errors.append("password: " + message)
        } catch {}
        
        if !isValid {
            throw ParseError.form(messages: errors)
        }
        
        return User(username: username, firstName: firstName, lastName: lastName, password: password)
    }
}
