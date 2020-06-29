//
//  MediaPostsViewModel.swift
//  Birdie
//
//  Created by Danijela Vrzan on 2020-06-29.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class MediaPostsViewModel {
    static let shared = MediaPostsViewModel()
    func setUpTableViewCell(for mediaPost: MediaPost, in tableView: UITableView) -> UITableViewCell {
        if let textPost = mediaPost as? TextPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell") as! TextPostTableViewCell
            cell.usernameLabel.text = textPost.userName
            cell.textPostLabel.text = textPost.textBody
            cell.timeLabel.text = textPost.timeStampString
            return cell
        } else if let imagePost = mediaPost as? ImagePost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagePostCell") as! ImagePostTableViewCell
            cell.usernameLabel.text = imagePost.userName
            cell.textPostLabel.text = imagePost.textBody
            cell.timeLabel.text = imagePost.timeStampString
            cell.imagePostImage.image = imagePost.image
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Unable to load feed"
            return cell
        }
    }
}
