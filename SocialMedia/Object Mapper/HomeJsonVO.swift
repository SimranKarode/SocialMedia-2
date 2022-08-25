//
//  HomeJsonVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 16/04/22.
//

import Foundation
import ObjectMapper
class HomeJsonVO: Mappable {
    
    var features_genre_and_movie : [FeatuerJsonVO]?
    var slider : SliderResultVO?

    init(features_genre_and_movie : [FeatuerJsonVO]?,slider : SliderResultVO?) {
        
        self.features_genre_and_movie = features_genre_and_movie
        self.slider = slider
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        features_genre_and_movie <- map["features_genre_and_movie"]
        slider <- map["slider"]
        
    }
}
