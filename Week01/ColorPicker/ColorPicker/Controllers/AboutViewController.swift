//
//  AboutViewController.swift
//  ColorPicker
//
//  Created by Danijela Vrzan on 2020-05-29.
//  Copyright © 2020 Danijela Vrzan. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    let rgbURL = "https://en.wikipedia.org/wiki/RGB_color_model"
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    func loadURL() {
        if let url = URL(string: rgbURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    //MARK: - Navigation
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}
