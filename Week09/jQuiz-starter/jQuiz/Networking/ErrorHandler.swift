//
//  ErrorHandler.swift
//  jQuiz
//
//  Created by Danijela Vrzan on 2020-07-24.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

enum ErrorFound: Error {
    case noNetworkConnection
}

extension ErrorFound: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetworkConnection:
            return NSLocalizedString("No network connection; please check your network connection and try again.", comment: "No Network Connection")
        }
    }
}
