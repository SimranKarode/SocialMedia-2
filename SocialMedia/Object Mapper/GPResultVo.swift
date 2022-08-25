//
//  GPResultVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 25/04/22.
//

import Foundation

import ObjectMapper

class GPResultVo: Mappable {
    
    var id : String?
    var images : String?

    init(id : String?, images : String?) {
        
        self.id = id
        self.images = images
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        id <- map["id"]
        images <- map["images"]
        
    }
}
