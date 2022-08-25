//
//  GraphicJsonVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 25/04/22.
//

import Foundation
import ObjectMapper

class GraphicJsonVo: Mappable {
    
    var output : [GPResultVo]?
    var message : String?
    var status : String?
    var tag : String?
       
    
    init(output : [GPResultVo]?, status : String?,message : String?,tag : String?) {
        self.output = output
        self.status = status
        self.message = message
        self.tag = tag
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        output <- map["output"]
        status <- map["status"]
        message <- map["message"]
        tag <- map["tag"]
        
    }
}
