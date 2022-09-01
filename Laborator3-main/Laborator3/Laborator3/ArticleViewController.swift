//
//  ArticleViewController.swift
//  Laborator3
//
//  Created by user216460 on 9/1/22.
//

import UIKit

class ArticleViewController: UIViewController{
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        
        textView.text = "cvrandom"
        
    }
}
