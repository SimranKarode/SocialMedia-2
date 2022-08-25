//
//  EpispdeResultVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 25/04/22.
//

import Foundation
import ObjectMapper

import ObjectMapper

class EpispdeResultVo: Mappable {
    
    var image_url : String?
    var videos_id : String?

    init(image_url : String?, videos_id : String?) {
        
        self.image_url = image_url
        self.videos_id = videos_id
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        image_url <- map["image_url"]
        videos_id <- map["videos_id"]
        
    }
}
