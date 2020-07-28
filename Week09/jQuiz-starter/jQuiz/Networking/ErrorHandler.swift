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
    case unknownError
    case invalidHttpResponse
}

extension ErrorFound: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetworkConnection:
            return NSLocalizedString("No network connection; please check your network connection and try again.", comment: "No Network Connection")
        case .invalidHttpResponse:
            return NSLocalizedString("Invalid HTTP response; there might be a problem with the server. Please try again later.", comment: "Invalid HTTP Response")
        case .unknownError:
            return NSLocalizedString("Unknown error; please check your internet connection or try again later.", comment: "Unknown Error")
        }
    }
}
