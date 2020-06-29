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
    
    var imageView = UIImageView()
    
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
        imageView.image = nil
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Write your post here"
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
        pickAnImageforImagePost()
    }
    
    func pickAnImageforImagePost() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        present(picker, animated: true, completion: nil)
    }
    
    func addNewImagePost() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Write your post here"
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
            let imagePost = ImagePost(textBody: text, userName: username ?? "N/A", timestamp: Date(), image: self.imageView.image!)
            MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
            self.tableview.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = MediaPostsViewModel.shared.setUpTableViewCell(for: post, in: tableView)
        
        return cell
    }
    
}

extension HomePageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] {
            imageView.image = image as? UIImage
            dismiss(animated: true, completion: nil)
            addNewImagePost()
        }
    }
}

