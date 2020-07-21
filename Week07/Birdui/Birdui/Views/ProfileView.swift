//
//  ProfileView.swift
//  Birdui
//
//  Created by Danijela Vrzan on 2020-07-13.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var post: MediaPost
    @State private var modalIsPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack {
                Image("profile-header-background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 200.0)
                Image("mascot_swift-badge")
                    .imageStyle(width: 120, height: 120)
                    .padding(.top, -70.0)
            }
            Text(post.userName).profileNameStyle()
            Spacer()
            Text("Quote of the day").profileQuoteTitleStyle()
            Divider()
                .padding(.horizontal, 30)
            Text(post.quote.rawValue)
                .italic()
                .profileQuoteTextStyle()
                .padding(.horizontal, 50)
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.down")
                    .imageStyle(width: 30, height: 30)
                    .dismissProfileButtonImageStyle()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(post:
            .constant(
                MediaPost(textBody: "Went to the Aquarium today :]",
                          userName: "Audrey",
                          timestamp: Date(timeIntervalSinceNow: -9876),
                          uiImage: UIImage(named: "octopus"),
                          reaction: Reaction.allCases.randomElement()!,
                          quote: Quote.allCases.randomElement()!
            ))
        )
    }
}
