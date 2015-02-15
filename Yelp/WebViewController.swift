//
//  WebViewController.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class WebViewController: UIViewController
{
    @IBOutlet weak var myWebView: UIWebView!
    
    var bizUrlStr: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println("web view did load")
        
        let url = NSURL(string: bizUrlStr)
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
    }

}
