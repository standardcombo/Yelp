//
//  YelpFilter.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class YelpFilter
{
    var sort: Int = 0 // 0 = Best Matched; 1 = Distance; 2 = Highest Rated
    var category_filter: String = "" // this may be called 'category' in api v1
    var radius_filter: Int = 16093 // Max value is 40000 (~25 miles)
    var deals_filter: Bool = false
    
}