//
//  NewsTableViewController.swift
//  newsApp
//
//  Created by Abdullah Oğuz on 24.06.2021.
//

import UIKit

class NewsTableViewController: UIViewController {

    @IBOutlet weak var newsTextArea: UITextView!
    var newsData: News?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTextArea.text = newsData?.news_text
        
    }

}
