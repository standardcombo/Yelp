//
//  YelpTableViewCell.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/13/15.
//  Copyright (c) 2015 Gabriel Santos. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell
{
    @IBOutlet weak var mainPicture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setData(data: NSDictionary, index: Int)
    {
//        println(data)
        
        if let image_url = data["image_url"] as? String
        {
            let url = NSURL(string: image_url)
            mainPicture.setImageWithURL(url)
        }
        
        if let name = data["name"] as? String
        {
            titleLabel.text = "\(index). \(name)"
        }
        
        if let rating_img_url = data["rating_img_url"] as? String
        {
            let url = NSURL(string: rating_img_url)
            ratingImage.setImageWithURL(url)
        }
        
        if let location = data["location"] as? NSDictionary
        {
            if let display_address = location["display_address"] as? NSArray
            {
                addressLabel.text = "\(display_address[0]), \(display_address[1])"
            }
            
            if let coordinate = location["coordinate"] as? NSDictionary
            {
                if let latitude = coordinate["latitude"] as? Float
                {
                    if let longitude = coordinate["longitude"] as? Float
                    {
                        println("coord: \(latitude),\(longitude)")
                        
                        let geoLoc = GeoCoordinate(latitude: latitude, longitude: longitude)
                        let code_path_boot_camp_geo_location = GeoCoordinate(latitude: 37.770706, longitude: -122.403511)
                        
                        let dist = code_path_boot_camp_geo_location.DistanceInMiles(geoLoc)
                        
                        distanceLabel.text = String(format: "%.1f mi", dist)
                    }
                }
            }
        }
        
        if let categories = data["categories"] as? NSArray
        {
            var str = ""
            for (var i = 0; i < categories.count; i++)
            {
                if let categ = categories[i] as? NSArray
                {
                    if let s = categ[0] as? String
                    {
                        str += s
                        
                        if i < categories.count - 1
                        {
                            str += ", "
                        }
                    }
                }
            }
            genreLabel.text = str
        }
        
        if let reviews = data["review_count"] as? Int
        {
            reviewLabel.text = "\(reviews) reviews"
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
