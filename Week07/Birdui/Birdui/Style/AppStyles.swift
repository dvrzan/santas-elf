//
//  AppModifiers.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 10/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

class AppStyles {
    
    struct HeaderTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 26))
        }
    }
    
    struct NewPostButtonTitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(10.0)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                .stroke(lineWidth: 2.0).size(width: 128, height: 41).fill())
                .padding(.leading, 16)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .accentColor(Color("accent"))
        }
    }
    
    struct DismissProfileButtonImageStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .frame(width: 100.0, height: 30.0)
                .accentColor(Color("accent"))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 2, x: 1, y: 1)
        }
    }
    
    struct PostTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(.system(size: 15.0))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    struct PostTitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.system(size: 20.0, weight: .semibold))
        }
    }
    
    struct PostSubTitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.caption)
                .foregroundColor(Color("accent"))
        }
    }
    
    struct ProfileNameStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(.system(size: 30.0, weight: .bold))
        }
    }
    
    struct ProfileQuoteTitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.system(size: 20.0, weight: .bold))
                .foregroundColor(Color("accent"))
        }
    }
    
    struct ProfileQuoteTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.gray)
                .font(.system(size: 15.0))
        }
    }
    
    struct ImageStyle: ViewModifier {
        var image: Image
        
        func body(content: Content) -> some View {
            return image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    
    struct ImageStyleWithFrame: ViewModifier {
        var image: Image
        var width: CGFloat
        var height: CGFloat
        
        func body(content: Content) -> some View {
            return image
                .modifier(ImageStyle(image: image))
                .frame(width: width, height: height)
        }
    }
    
    struct HeaderImageStyle: ViewModifier {
        var image: Image
        var width: CGFloat
        var height: CGFloat
        
        func body(content: Content) -> some View {
            return image
                .modifier(ImageStyleWithFrame(image: image, width: width, height: height))
                .padding(.leading, 16)                
        }
    }
    
}
