//
//  GetProfileVO.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 21/04/22.
//

import Foundation

//
import ObjectMapper

class GetProfileVO: Mappable {
    
    //MARK:-  Declaration of GetProfileVO
    var status: String?
    var image_url: String?
    var name: String?
    var email: String?
    var phone: String?
    var company_name: String?
    var adress: String?
    var website: String?
    var business_type: String?
    
    var data: String?
    var code: Int?

    
    
    //MARK:-  initialization of GetProfileVO
    init(status :String? , image_url:String?,name:String?,email:String?,phone:String?,company_name:String?,adress:String?,website:String?,business_type:String?,code:Int?,data: String?){
        self.status = status
        self.image_url = image_url
        self.name = name
        self.email = email
        self.phone = phone
        self.company_name = company_name
        self.adress = adress
        self.website = website
        self.business_type = business_type
        
        self.data = data
        self.code = code
        
        
    }
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        status <- map["status"]
        image_url <- map["image_url"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        company_name <- map["company_name"]
        adress <- map["adress"]
        website <- map["website"]
        business_type <- map["business_type"]
        
        data <- map["data"]
        code <- map["code"]
        
        
    }
}
