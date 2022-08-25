//
//  CategoryListJsonVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 24/04/22.
//

import Foundation
import ObjectMapper

class CategoryListJsonVO: Mappable {
    
    var season : [CategoryResultVO]?
    var title : String?

    init(season : [CategoryResultVO]?, title : String?) {
        
        self.season = season
        self.title = title
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        season <- map["season"]
        title <- map["title"]
        
    }
}
