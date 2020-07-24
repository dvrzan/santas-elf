//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

protocol NetworkingErrorDelegate {
    func didFailWithError(error: Error)
}

class Networking {
    
    static let sharedInstance = Networking()
    var clues = [Clue]()
    
    var delegate: NetworkingErrorDelegate?
    
    private init() {}
    
    func getClues(url: URL, _ tableView: UITableView?) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error1: \(error)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
                //self.delegate?.didFailWithError(error: ErrorFound.noNetworkConnection)
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }
            do {
                let decoder = JSONDecoder()
                let clues = try decoder.decode([Clue].self, from: data)
                DispatchQueue.main.async {
                    tableView?.reloadData()
                }
                self.clues = clues
            }
            catch {
                print("Error2: \(error)")
            }
        }
        task.resume()
    }
    
}
