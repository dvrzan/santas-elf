//
//  PostListView.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 9/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var postHandler: PostViewModel
    @State private var modalIsPresented = false
    @State private var isFilteringLovedPosts: Bool = false
    
    var body: some View {
        
        VStack {
            PostListHeaderView(modalIsPresented: $modalIsPresented)            
            List {
                Toggle(isOn: $isFilteringLovedPosts) {
                    Text(verbatim: "Show only loved posts")
                        .font(.caption)
                }
                ForEach(postHandler.posts) { index in
                    if !self.isFilteringLovedPosts || self.postHandler.posts[index].reaction == .love {
                        PostListRowView(post: self.$postHandler.posts[index])
                    }
                }
                if self.isFilteringLovedPosts && self.postHandler.countLoveReactions() {
                    VStack(alignment: .center) {
                        Image("empty-list")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                }
            }
        }
        .sheet(isPresented: $modalIsPresented) {
            NewPostView(postHandler: self.postHandler)
        }
        .onAppear(perform: {
            UITableView.appearance().separatorStyle = .none
        })
        
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(postHandler: PostViewModel())
    }
}
