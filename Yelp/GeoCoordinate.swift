//
//  GeoCoordinate.swift
//  Yelp
//
//  Created by Gabriel Santos on 2/14/15.
//  Copyright (c) 2015 Gabriel Santos. All rights reserved.
//

import Foundation

struct GeoCoordinate
{
    let EARTH_RADIUS: Float = 6373 // km
    let latitude, longitude: Float
    let latitude_r, longitude_r: Float // radian versions
    
    init(latitude: Float, longitude: Float)
    {
        self.latitude = latitude
        self.longitude = longitude
        
        self.latitude_r = latitude / 180 * Float(M_PI)
        self.longitude_r = longitude / 180 * Float(M_PI)
    }
    
    func Distance(loc: GeoCoordinate) -> Float
    {
        let dlon = loc.longitude_r - self.longitude_r
        let dlat = loc.latitude_r - self.latitude_r
        
        let sin_dlat = sin(dlat / 2)
        let sin_dlon = sin(dlon / 2)
        let a = sin_dlat * sin_dlat + cos(self.latitude_r) * cos(loc.latitude_r) * sin_dlon * sin_dlon
        let c = 2 * atan2( sqrt(a), sqrt(1 - a) )
        let d = EARTH_RADIUS * c
        
        return d
    }
    
    func DistanceInMiles(loc: GeoCoordinate) -> Float
    {
        return Distance(loc) * 0.621371
    }
}