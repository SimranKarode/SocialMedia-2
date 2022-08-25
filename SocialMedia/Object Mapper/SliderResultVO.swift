//
//  SliderResultVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 23/04/22.
//

import Foundation
import ObjectMapper

class SliderResultVO: Mappable {
    var slide : [SliderJsonVO]?
    //MARK:-  initialization of SliderResultVO
    init(slide : [SliderJsonVO]?) {
        self.slide = slide
    }
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        slide <- map["slide"]
    }
}
