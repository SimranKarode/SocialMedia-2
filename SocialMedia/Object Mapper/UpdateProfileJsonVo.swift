//
//  UpdateProfileJsonVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 19/04/22.
//

import Foundation
import ObjectMapper

class UpdateProfileJsonVo: Mappable {
    
    //MARK:-  Declaration of HomeJsonVo
    var status: String?
    var data:String?
    var image_url: String?
    //MARK:-  initialization of LoginJsonVO
    init(status :String? ,data:String?, image_url:String?){
        self.status = status
        self.data = data
        self.image_url = image_url
    }
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        image_url <- map["image_url"]
        
    }
}
