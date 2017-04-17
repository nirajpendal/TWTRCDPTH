//
//  User.swift
//  TWTRCDPTH
//
//  Created by Niraj Pendal on 4/14/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import Foundation

class User {
    
    var name: String?
    var tagLine: String?
    var profileURL: URL?
    var screenName: String?
    
    var tweets:[Tweet]?
    
    init(dictionary: [String:AnyObject]) {
        
        name = dictionary ["name"] as? String
        tagLine = dictionary ["description"] as? String
        let profileString = dictionary ["profile_background_image_url_https"] as? String
        
        if let profileStringNotNil = profileString {
            profileURL = URL(string: profileStringNotNil)!
        }
        
        screenName =  dictionary ["screen_name"] as? String
        
    }
    
}
