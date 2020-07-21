//
//  PostView.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 9/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListRowView: View {
    
    @Binding var post: MediaPost
    @State private var modalIsPresented = false
    
    var body: some View {
        
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Button(
                            action: { self.modalIsPresented = true }
                        ) {
                            Image("mascot_swift-badge")
                                .renderingMode(.original)
                                .imageStyle(width: 50, height: 50)
                        }
                        VStack(alignment: .leading) {
                            Text(post.userName)
                                .postTitleStyle()
                            Text(post.timestamp.formatted)
                                .postSubTitleStyle()
                        }
                        Spacer()
                    }
                    if post.textBody != nil {
                        Text(post.textBody!)
                            .postTextStyle()
                    }
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                if post.uiImage != nil {
                    Image(uiImage: post.uiImage!)
                        .imageStyle(width: 200, height: 200)
                }
            }
            .background(Color("post-background"))
            .cornerRadius(20)
            .shadow(radius: 10)
            
            Picker("Reaction", selection: $post.reaction) {
                ForEach(Reaction.allCases, id: \.self) { reaction in
                    Text(reaction.rawValue).tag(reaction)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
                
            .padding(.horizontal, 60)
                
            .sheet(isPresented: $modalIsPresented) {
                ProfileView(post: self.$post)
            }
        }
        .padding(.vertical, 20)
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostListRowView(post:
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
