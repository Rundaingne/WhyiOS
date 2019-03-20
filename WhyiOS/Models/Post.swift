//
//  Post.swift
//  WhyiOS
//
//  Created by Brooke Kumpunen on 3/20/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let cohort: String
    let name: String
    let reason: String
    
    //If the keys were named something other than these in our API, I would want to create some codingKeys here as such:
    //enum CodingKeys: String, CodingKey {
    //Within the code brackets, I would add a case for each of MY properties, and then write = "Corresponding key within the API." And that's it!
    //}
    
}
