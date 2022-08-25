//
//  SubscriptJsonVO.swift
//  SocialMedia
//
//  Created by Abdul on 27/06/22.
//

import Foundation
import ObjectMapper

class SubscriptJsonVO: Mappable {
    
    var status: String?
    var active_subscription : [SubscriptResultVO]?
    var inactive_subscription : [SubscriptResultVO]?
    
    init(status: String?,active_subscription : [SubscriptResultVO]?, inactive_subscription : [SubscriptResultVO]?) {
        
        self.status = status
        self.active_subscription = active_subscription
        self.inactive_subscription = inactive_subscription
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        status <- map["status"]
        active_subscription <- map["active_subscription"]
        inactive_subscription <- map["inactive_subscription"]
        
    }
}
