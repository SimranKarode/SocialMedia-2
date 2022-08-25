//
//  CategoryResultVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 24/04/22.
//

import Foundation
import ObjectMapper

class CategoryResultVO: Mappable {
    
    var episodes : [EpispdeResultVo]?

    init(episodes : [EpispdeResultVo]?) {
        
        self.episodes = episodes
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        episodes <- map["episodes"]
        
    }
}
