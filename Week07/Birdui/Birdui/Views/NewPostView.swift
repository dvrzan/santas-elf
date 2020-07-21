//
//  NewPostView.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 9/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    
    var postHandler: PostViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var username: String = ""
    @State var postText: String = ""
    @State var showImagePicker = false
    @State var uiImage: UIImage?
    
    let imageSize: CGFloat = 200
    
    var body: some View {
        
        VStack {
            Text("New Post")
                .font(.title)
                .padding(.vertical, 20.0)
            Form {
                TextField("Username", text: $username)
                Button("Pick image") {
                    self.showImagePicker = true
                }
                if uiImage != nil {
                    Image(uiImage: uiImage!).imageStyle(width: imageSize, height: imageSize)
                }
                TextField("Post text", text: $postText)
            }
            HStack {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Post") {
                    self.postHandler.addPost(post:
                        MediaPost(textBody: self.postText,
                                  userName: self.username,
                                  timestamp: Date(),
                                  uiImage: self.uiImage,
                                  reaction: Reaction.allCases.randomElement()!,
                                  quote: Quote.allCases.randomElement()!))
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(username.isEmpty && postText.isEmpty)
            }
            .padding()
        }
        .accentColor(Color("accent"))
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$uiImage)
        }
        
    }
    
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(postHandler: PostViewModel())
    }
}

