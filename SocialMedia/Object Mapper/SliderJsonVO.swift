//
//  SliderJsonVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 23/04/22.
//

import Foundation
import ObjectMapper

class SliderJsonVO: Mappable {
    var image_link : String?
    //MARK:-  initialization of SliderJsonVO
    init(image_link : String?) {
        self.image_link = image_link
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        image_link <- map["image_link"]
    }
}
