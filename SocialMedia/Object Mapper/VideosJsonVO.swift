//
//  VideosVo.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 16/04/22.
//

import Foundation
import ObjectMapper

class VideosJsonVO: Mappable {
    var title : String?
    var poster_url : String?
    var videos_id : String?
    var release : String?

    //MARK:-  initialization of VideosJsonVO
    init(title:String?,poster_url:String?,videos_id : String?,release : String?) {
        self.title = title
        self.poster_url = poster_url
        self.videos_id = videos_id
        self.release = release

    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        title <- map["title"]
        poster_url <- map["poster_url"]
        videos_id <- map["videos_id"]
        release <- map["release"]

    }
}
