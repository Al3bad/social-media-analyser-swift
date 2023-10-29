//
//  UserDetailsView.swift
//  SocialMediaAnalyserGUI
//
//  Created by Abdullah Alabbad on 28/10/2023.
//

import SwiftUI

struct UserDetailsView: View {
    var firstName: String
    var lastName: String
    var username: String
    
    var body: some View {
        HStack (spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.gray)
                    .opacity(0.5)
                    .frame(width: 64)
                Circle()
                    .fill(Color.gray.gradient)
                    .rotationEffect(.degrees(45))
                    .frame(width: 60)
            }
            VStack (alignment: .leading) {
                Text("\(firstName) \(lastName)")
                Text("@\(username)")
                    .font(.subheadline)
                    .foregroundStyle(.opacity(0.5))
            }
            Spacer()
        }
//        .padding(32)
    }
}

#Preview {
    UserDetailsView(firstName: "fname", lastName: "lname", username: "username")
}
