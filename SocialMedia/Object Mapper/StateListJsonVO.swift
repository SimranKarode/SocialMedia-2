//
//  StateListJsonVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 18/04/22.
//

import Foundation
import ObjectMapper

class StateListJsonVO: Mappable {
    
    //MARK:-  Declaration of HomeJsonVo
    var status: String?
    var message:String?
    var output:[StateResultVO]?
    //MARK:-  initialization of LoginJsonVO
    init(status :String? ,message:String?, output:[StateResultVO]? ) {
        self.status = status
        self.message = message
        self.output = output
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        output <- map["output"]
        
    }
}
