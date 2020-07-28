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
    
    let randomEndpoint = "http://www.jservice.io/api/random"
    let categoryEndpoint = "http://www.jservice.io/api/clues?category="
    let imageURL = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
    
    var delegate: NetworkingErrorDelegate?
    
    private init() {}
    
    //    func getClue(url: URL) {
    //        let configuration = URLSessionConfiguration.default
    //        let session = URLSession(configuration: configuration)
    //
    //        let task = session.dataTask(with: url) { data, response, error in
    //            if let error = error {
    //                fatalError("Error1: \(error)")
    //            }
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                fatalError("Error: invalid HTTP response code")
    //                //self.delegate?.didFailWithError(error: ErrorFound.noNetworkConnection)
    //            }
    //            guard let data = data else {
    //                fatalError("Error: missing response data")
    //            }
    //            do {
    //                let decoder = JSONDecoder()
    //                let clue = try decoder.decode([Clue].self, from: data)
    //            }
    //            catch {
    //                print("Error2: \(error)")
    //            }
    //        }
    //        task.resume()
    //    }
    
    func getRandomCategory(completion: @escaping (Int?) -> ()) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = URL(string: randomEndpoint)!
        
        let task = session.dataTask(with: url) { data, response, error in
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
                let clue = try decoder.decode([Clue].self, from: data)
                for c in clue {
                    completion(c.categoryID)
                }
            }
            catch {
                print("Error2: \(error)")
            }
        }
        task.resume()
    }
    
    func getAllCluesInCategory(categoryId: Int, completion: @escaping ([Clue]) -> ()) {i
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = URL(string: categoryEndpoint + String(describing: categoryId))!
        
        let task = session.dataTask(with: url) { data, response, error in
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
                let nonNilClues = clues.compactMap { $0 }
                let limitClues = nonNilClues.limit(4)
                completion(limitClues)
            }
            catch {
                print("Error2: \(error)")
            }
        }
        task.resume()
    }
    
    func getHeaderImage(headerImage: UIImageView) {
        guard let imageUrl = URL(string: imageURL) else {
            return
        }
        let task = URLSession.shared.downloadTask(with: imageUrl) { location, response, error in
            guard let location = location,
                let imageData = try? Data(contentsOf: location),
                let image = UIImage(data: imageData) else {
                    return
            }
            DispatchQueue.main.async {
                headerImage.image = image
            }
        }
        task.resume()
    }
    
}
