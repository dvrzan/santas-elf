//
//  ClueGameModel.swift
//  jQuiz
//
//  Created by Danijela Vrzan on 2020-07-25.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

protocol ClueGameModelDelegate {
    func willShowGameInfo(answer: Answer)
}

struct ClueGameModel {
    var score = 0
    var correctAnswerClue: Clue!
    
    var delegate: ClueGameModelDelegate?
    
    mutating func calculatePoints(clue: Clue) {
        if correctAnswerClue.answer == clue.answer {
            let points = correctAnswerClue.value ?? 100
            score += points
            delegate?.willShowGameInfo(answer: .correct)
        } else {
            delegate?.willShowGameInfo(answer: .wrong)
        }
    }
}

enum Answer: String {
    case correct
    case wrong
}

extension Answer: RawRepresentable {
    typealias RawValue = String
    
    init?(title: RawValue, message: RawValue) {
        switch title {
            case "Correct": self = .correct
            case "Wrong": self = .wrong
            default: return nil
        }
        switch message {
            case "Correct": self = .correct
            case "Wrong": self = .wrong
            default: return nil
        }
    }
    
    var title: String {
        switch self {
            case .correct: return "Well done! 🥳"
            case .wrong: return "Oh no! 😱"
        }
    }
    var message: String {
        switch self {
            case .correct: return "You are going up "
            case .wrong: return "You just lost yourself "
        }
    }
}
