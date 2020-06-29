//
//  ViewController.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "TextPostTableViewCell", bundle: nil), forCellReuseIdentifier: "TextPostCell")
        tableview.register(UINib(nibName: "ImagePostTableViewCell", bundle: nil), forCellReuseIdentifier: "ImagePostCell")
        
        MediaPostsHandler.shared.getPosts()
        
    }
    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        addNewTextPost()
    }
    
    func addNewTextPost() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Write your text here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            alert.textFields?.forEach { (textField) in
                if textField.text == nil {
                    textField.text = "N/A"
                }
            }
            let username = alert.textFields?[0].text
            let text = alert.textFields?[1].text
            let textPost = TextPost(textBody: text, userName: username ?? "N/A", timestamp: Date())
            MediaPostsHandler.shared.addTextPost(textPost: textPost)
            self.tableview.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        if let textPost = post as? TextPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell") as! TextPostTableViewCell
            cell.usernameLabel.text = textPost.userName
            cell.textPostLabel.text = textPost.textBody
            cell.timeLabel.text = textPost.timeStampString
            return cell
        } else if let imagePost = post as? ImagePost {
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



