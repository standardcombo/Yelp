//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate
{
    var client: YelpClient!
    var dataArray: NSArray?
    var networkError: Bool = false
    var searchTerm: String = ""
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "_0ZgjQ3ruYuw213HuXaqMw"//"vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "DMBkUNH01MH9sFNTSNA_gq_xENk"//"33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "Oxf8V9ZUljfHB01-FqKRzx0OkZfYEked"//"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "lqfHcRBCKZzGVIG3r8SUou-Kvrc"//"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set status bar to white
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        // Search bar
        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        // Resize rows
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 90.0;
        
        reload()
    }
    
    func reload()
    {
        println("Reloading")
        
        showActivity()
        
        if activeOperation != nil
        {
            activeOperation.cancel()
        }
        
        activeOperation = client.searchWithTerm(searchTerm, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            self.dataArray = response["businesses"] as? NSArray
            
            self.networkError = false
            self.hideActivity()
            self.tableView.reloadData()
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
            if !operation.cancelled
            {
                println(error)
                
                self.networkError = true
                self.hideActivity()
                self.tableView.reloadData()
            }
        }
    }
    
    var activeOperation: AFHTTPRequestOperation!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (networkError)
        {
            return 1;
        }
        if (dataArray != nil)
        {
            var i:Int? = dataArray?.count as Int?
            
            println("\(i!) cells")
            
            return i!
        }
        println("0 cells");
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if ( !networkError )
        {
            let index:Int = indexPath.row
            
            let cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as YelpTableViewCell;
            
            if (dataArray?.count >= index)
            {
                let data: NSDictionary = self.dataArray?[index] as NSDictionary;
                
                cell.setData(data, index: index+1)
                
            }
            return cell;
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("networkErrorCell") as UITableViewCell;
            return cell;
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if ( !networkError )
        {
            //            let detailsView: MovieDetailsViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("detailsView") as MovieDetailsViewController
            //
            //            let index:Int = indexPath.row
            //            let movie: NSDictionary = self.moviesArray?[index] as NSDictionary
            //            detailsView.movieData = movie
            //
            //            self.showViewController(detailsView, sender: detailsView)
        }
        else {
            reload()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.searchTerm = searchText
        reload()
    }
    
    @IBAction func filterPressed(sender: AnyObject)
    {
        let filterView: FilterViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("filterView") as FilterViewController
        
        filterView.filter = client.filter
        
        self.showViewController(filterView, sender: filterView)
    }
    
    func showActivity()
    {
        if actInd == nil
        {
            actInd = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
            actInd?.center = self.view.center
            actInd?.hidesWhenStopped = true
            actInd?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(actInd!)
            actInd?.startAnimating()
        }
    }
    
    func hideActivity()
    {
        actInd?.stopAnimating()
        actInd?.removeFromSuperview()
        actInd = nil
    }
    
    var actInd: UIActivityIndicatorView?
    
    func TestGeoDistance()
    {
        let geo1 = GeoCoordinate(latitude: 37.770706, longitude: -122.403511)
        let geo2 = GeoCoordinate(latitude: 37.770649, longitude: -122.402799)
        
        println("distance in km: \(geo1.Distance(geo2))")
        println("distance in mi: \(geo1.DistanceInMiles(geo2))")
    }
}

