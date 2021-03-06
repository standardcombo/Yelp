//
//  FilterViewController.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dealsSwitch: UISwitch!
    
    let categoryStrings = ["Everything", "Restaurants", "Bars", "Coffee & Tea", "Delivery", "Nightlife", "Gas & Vehicle", "Drugstores", "Shopping"]
    let categoryData = ["", "restaurants", "bars", "coffee", "couriers", "nightlife", "servicestations", "drugstores", "shopping"]
    
    let sortStrings = ["Best Match", "Distance", "Highest Rated"]
    
    var filter = YelpFilter()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setTitleLabel()
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let categoryIndex: Int = find(categoryData, filter.category_filter)!
        
        categoryPicker.selectRow(categoryIndex, inComponent: 0, animated: false)
        categoryPicker.selectRow(filter.sort, inComponent: 1, animated: false)
        
        setDistanceWithMeters(filter.radius_filter)
        
        dealsSwitch.on = filter.deals_filter
    }
    
    @IBAction func searchPressed(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
        
        let baseView = self.navigationController?.topViewController as ViewController
        
        // TODO : set filter... maybe not needed now that we are receiving the filter object from the previous view
        
//        baseView.client.filter = self.filter
        
        baseView.reload()
    }
    
// Category and Sort pickers
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0
        {
            return categoryStrings.count
        }
        return sortStrings.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        if component == 0
        {
            return categoryStrings[row]
        }
        return sortStrings[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == 0
        {
            // Category
            filter.category_filter = categoryData[row]
        }
        else
        {
            // Sort
            filter.sort = row
        }
    }
    
// Distance
    
    @IBAction func distanceValueChanged(sender: AnyObject)
    {
        let miles = self.distanceSlider.value
        var meters = Int(miles * 1609.34)
        
        if meters > 40000
        {
            meters = 40000
        }
        filter.radius_filter = meters
        
        setDistanceWithMiles(miles)
    }
    
    func setDistanceWithMeters(meters: Int)
    {
        let miles = Float(meters) / 1609.34
        setDistanceWithMiles(miles)
        
        self.distanceSlider.value = miles
    }
    
    func setDistanceWithMiles(miles: Float)
    {
        distanceLabel.text = String(format: "%.1f mi", miles)
    }
    
// Deals
    
    @IBAction func dealsSwitchChanged(sender: AnyObject)
    {
        filter.deals_filter = dealsSwitch.on
    }
    
// Title
    
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
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
//    {
//        println("prepareForSegue")
//        if (segue.identifier == "segueTest") {
//            var svc = segue!.destinationViewController as secondViewController;
//            
//            svc.toPass = textField.text
//            
//        }
//    }
    

    

}
