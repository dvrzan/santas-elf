//
//  MediaPost.swift
//  Birdui
//
//  Created by Asif Ahmed Jesi on 9/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation
import UIKit

struct MediaPost: Identifiable {
    let id = UUID()
    let textBody: String?
    let userName: String
    let timestamp: Date
    let uiImage: UIImage?
    var reaction: Reaction
    var quote: Quote
}

enum Reaction: String, CaseIterable {
    case love = "❤️"
    case funny = "😂"
    case unsure = "😐"
    case shock = "😱"
}

enum Quote: String, CaseIterable {
    case one = "\"Programs must be written for people to read, and only incidentally for machines to execute.\" \n- Martin Fowler"
    case two = "\"Truth can only be found in one place: the code.\" \n- Robert C. Martin"
    case three = "\"Give a man a program, frustrate him for a day. Teach a man to program, frustrate him for a lifetime.\" \n- Muhammad Waseem"
    case four = "\"That's the thing about people who think they hate computers. What they really hate is lousy programmers.\" \n- Larry Niven"
    case five = "\"A language that doesn't affect the way you think about programming is not worth knowing.\" \n- Alan J. Perlis"
    case six = "\"Take time to learn the closest thing that we have to a SUPERPOWER - Code.\" \n- Sharen Eddings"
    case seven = "\"Programming isn't about what you know; it's about what you can figure out.\" \n- Chris Pine"
    case eight = "\"Think twice, code once.\" \n- Waseem Latif"
    case nine = "\"Learning the art of programming, like most other disciplines, consists of first learning the rules and then learning when to break them.\" \n- Joshua Bloch"
    case ten = "\"If you're good at the debugger it means you spent a lot of time debugging. I don't want you to be good at the debugger.\" \n- Robert C. Martin"
}
