//
//  AlamofireApi.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 18/04/22.
//

import Foundation
import JGProgressHUD

//open class API: NSObject {
//
//    struct Singleton {
//        static let sharedInstance = API()
//    }
//
//    class var sharedInstance: API {
//        return Singleton.sharedInstance
//    }
//
//    func apiCall(apiEndPoint:String, parameters:Dictionary<String,Any>?,block mainBlock:((Dictionary<String,Any>?,NSError?,Int,Bool)->Void?)?){
//
//
//        let apiToContact = API_URL + apiEndPoint
////        SVProgressHUD.show()
//
//        Alamofire.request(apiToContact, method: HTTPMethod.post, parameters: parameters, headers: nil).responseData(queue: .main) { (response) in
//
//            print("API Name :::::::::::::::::: %@",response.request!.url ?? "No URL")
//            print("Parameters :::::::::::::::::: %@",parameters as! Parameters)
//
//            SVProgressHUD.dismiss()
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//
//                    print(json)
//                    let data = json.dictionaryObject as! Dictionary<String, Any>
//                    if (data["is_login"] != nil){
//                        let is_login = data["is_login"] as! Bool
//                        if !is_login{
//                            Toast(text: data["message"] as! String, delay: 0.0, duration: timeInterval).show()
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                                removeLoginUserData()
//                            })
//                            return
//                        }
//                    }
//                    // Do what you need to with JSON here!
//                    // The rest is all boiler plate code you'll use for API requests
//
//                    mainBlock?(json.dictionaryObject as Dictionary<String, Any>?,nil,(response.response?.statusCode)!,true)
//
//                }
//            case .failure(let error):
//                mainBlock?(nil,error as NSError?, 400,false)
//                print(error)
//            }
//        }
//    }
//}
