//
//  ParseValueError.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 31/10/2023.
//

enum ParseError: Error {
    case withMessage(message: String)
    case form(messages: [String])
}
