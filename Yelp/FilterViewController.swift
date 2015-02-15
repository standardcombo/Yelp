//
//  FilterViewController.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setTitleLabel()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }
    
    func setTitleLabel()
    {
        let label = UILabel(frame: CGRectZero)
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.boldSystemFontOfSize(20.0)
        label.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = label
        label.text = "Filter"
        label.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
