//
//  PostListHeaderView.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 10/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListHeaderView: View {
    
    @Binding var modalIsPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            HStack(alignment: .center) {
                Image("mascot_swift-badge").headerImageStyle(width: 50, height: 50)
                Text("HOME").headerTextStyle()
            }            
            Button(action: {
                self.modalIsPresented = true
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "square.and.pencil")
                    Text("New Post")
                }
                .newPostButtonTitleStyle()
            }
        }
        
    }
    
}

struct PostListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PostListHeaderView(modalIsPresented: .constant(false))
    }
}
