//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Codable {
    let id: Int
    let answer: String?
    let question: String?
    let value: Int?
    let categoryID: Int
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case id, answer, question, value
        case categoryID = "category_id"
        case category
    }
}

struct Category: Codable {
    let id: Int
    let title: String
}

