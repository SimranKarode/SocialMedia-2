//
//  FeatureList.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 16/04/22.
//

import Foundation
import ObjectMapper

class FeatuerJsonVO: Mappable {
    var genre_id : String?
    var name : String?
    var videos : [VideosJsonVO]?

    //MARK:-  initialization of FeatuerJsonVO
    init(genre_id : String?,name : String?,videos : [VideosJsonVO]?) {
        
        self.name = name
        self.videos = videos
        self.genre_id =  genre_id
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        videos <- map["videos"]
        genre_id <- map["genre_id"]
        
    }
}
