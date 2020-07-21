//
//  PostViewModel.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 9/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//
import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    
    @Published var posts: [MediaPost] = [MediaPost]()
    
    init() {
        let imagePost1 = MediaPost(textBody: "I love debugging software!", userName: "Jay", timestamp: Date(timeIntervalSinceNow: -123456), uiImage: UIImage(named: "chop"), reaction: Reaction.allCases.randomElement()!, quote: Quote.allCases.randomElement()!)
        let imagePost2 = MediaPost(textBody: "Went to the Aquarium today :]", userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: UIImage(named:  "octopus"), reaction: Reaction.allCases.randomElement()!, quote: Quote.allCases.randomElement()!)
        let textPost1 = MediaPost(textBody: "Hello World!", userName: "Bhagat", timestamp: Date(timeIntervalSinceNow: -67890), uiImage: nil, reaction: Reaction.allCases.randomElement()!, quote: Quote.allCases.randomElement()!)
        let textPost2 = MediaPost(textBody: "This is my favorite social media app! This is my favorite social media app! This is my favorite social media app!", userName: "Jeff", timestamp: Date(timeIntervalSinceNow: -2345), uiImage: nil, reaction: Reaction.allCases.randomElement()!, quote: Quote.allCases.randomElement()!)
        
        posts = [imagePost1, imagePost2, textPost1, textPost2].sorted(by: { $0.timestamp > $1.timestamp })
    }
    
    func addPost(post: MediaPost) {
        posts.append(post)
        posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
    }
    
    func countLoveReactions() -> Bool {
        if posts.filter({ $0.reaction == .love }).count == 0 {
            return true
        } else {
            return false
        }
    }
    
}
