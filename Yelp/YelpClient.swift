//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager
{
    var accessToken: String!
    var accessSecret: String!
    
    var filter = YelpFilter()
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!)
    {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation!
    {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        var parameters = [
            "term": term,
            "location": "600 Townsend Street, San Francisco, CA",
            "sort":filter.sort,
            "category_filter":filter.category_filter,
            "radius_filter":filter.radius_filter,
            "deals_filter":filter.deals_filter]
        
        let operation = self.GET("search", parameters: parameters, success: success, failure: failure) as AFHTTPRequestOperation
        return operation
    }
    
}


