//
//  Sequence+Filter.swift
//  jQuiz
//
//  Created by Danijela Vrzan on 2020-07-27.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}
