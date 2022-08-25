//
//  SubscriptResultVO.swift
//  SocialMedia
//
//  Created by Abdul on 27/06/22.
//

import Foundation
import ObjectMapper

class SubscriptResultVO: Mappable {
    
    var subscription_id : String?
    var plan_id : String?
    var plan_title : String?
    var user_id : String?
    var price_amount : String?
    var videos_id : String?
    var paid_amount : String?
    var start_date : String?
    var expire_date : String?
    var payment_method : String?
    var payment_info : String?
    var payment_timestamp : String?
    var status : String?
    var invoice : String?
    
    
    

    init(subscription_id : String?, plan_id : String?,plan_title : String?, user_id : String?,price_amount : String?,videos_id : String?,paid_amount : String?,start_date : String?,expire_date : String?,payment_method : String?,payment_info : String?,payment_timestamp : String?,status : String?,invoice : String?) {
        
        self.subscription_id = subscription_id
        self.plan_id = plan_id
        self.plan_title = plan_title
        self.user_id = user_id
        self.price_amount = price_amount
        self.videos_id = videos_id
        self.paid_amount = paid_amount
        self.start_date = start_date
        self.expire_date = expire_date
        self.payment_method = payment_method
        self.payment_info = payment_info
        self.payment_timestamp = payment_timestamp
        self.status = status
        self.invoice = invoice
        
    }
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        subscription_id <- map["subscription_id"]
        plan_id <- map["plan_id"]
        plan_title <- map["plan_title"]
        user_id <- map["user_id"]
        price_amount <- map["price_amount"]
        videos_id <- map["videos_id"]
        paid_amount <- map["paid_amount"]
        start_date <- map["start_date"]
        expire_date <- map["expire_date"]
        payment_method <- map["payment_method"]
        payment_info <- map["payment_info"]
        payment_timestamp <- map["payment_timestamp"]
        status <- map["status"]
        invoice <- map["invoice"]
        
        
    }
}

