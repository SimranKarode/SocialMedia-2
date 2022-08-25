//
//  StateResultVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 18/04/22.
//

import Foundation
import ObjectMapper

class StateResultVO: Mappable {
    
    //MARK:-  Declaration of FeatureList
    var id: String?
    var name: String?
    
    //MARK:-  initialization of FeatureList
    init(id: String?,name:String?) {
        self.name = name
        self.id = id

    }
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]

    }
}
