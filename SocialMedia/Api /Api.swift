//
//  Api.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 07/04/22.
//

import Foundation
import UIKit

//class APIClient: NSObject {
//
//    static let sharedInstance = APIClient()
////    let reachability = Reachability()!
//    var appDelegate = AppDelegate()
//
//    func loginPost(strURL:NSString,mobile_no:String,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
////        if appDelegate.checkInternetConnectivity() == false {
////            UIApplication.shared.isNetworkActivityIndicatorVisible = false
////            //appDelegate.showAlert()
////            //appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:.center)
////            self.appDelegate.showAlert(alertTitle: "Alert!", aleertMessage: kNetworkStatusMessage)
////            return
////        }
//        let request = NSMutableURLRequest(url: NSURL(string: strURL as String)! as URL)
//       // showLoadingHUD(to_view:appDelegate.window!)
//        request.httpMethod = "POST"
//        let postString = "mobile_no=\(mobile_no)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
////            if error != nil {
////                print("error=\(error)")
////                return
////            }
//           // hideLoadingHUD(for_view: self.appDelegate.window!)
//            if response != nil {
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                if statusCode == 400 {
//                    failureHandler("Error")
//                    print("error=\(String(describing: error))")
//
//
//                }
//                if statusCode == 404 {
//                    failureHandler("Error")
//                    print("error=\(String(describing: error))")
//                    // self.appDelegate.window?.makeToast("\(String(describing: error))", duration:kToastDuration , position:.center)
//                    //                        self.appDelegate.showAlert(alertTitle: "Alert!", aleertMessage: "\(String(describing: error))")
//
//
//                }
//                if statusCode == 401 {
//                    failureHandler("unAuthorized")
//                }
//                if statusCode == 500 {
//                    print("failuer 1")
//                    failureHandler("unAuthorized")
//                }
//                if statusCode == 200 {
//                    do {
//                        let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
//                        print(parsedData)
//                        successHandler(parsedData as AnyObject)
//                    } catch let error as NSError {
//                        print("error=\(error)")
//                        return
//                    }
//                }else{
//                    print("Faild response = \(String(describing: statusCode))")
//
//                }
//            }
//            print("responseString = \(String(describing: response))")
//        }
//        task.resume()
//    }
//    func ABOUTUS(strURL:NSString,mobile_no:String,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
////        if appDelegate.checkInternetConnectivity() == false {
////            UIApplication.shared.isNetworkActivityIndicatorVisible = false
////            //appDelegate.showAlert()
////            //appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:.center)
////            self.appDelegate.showAlert(alertTitle: "Alert!", aleertMessage: kNetworkStatusMessage)
////            return
////        }
//        let request = NSMutableURLRequest(url: NSURL(string: strURL as String)! as URL)
//       // showLoadingHUD(to_view:appDelegate.window!)
//        request.httpMethod = "POST"
//        let postString = "mobile_no=\(mobile_no)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
////            if error != nil {
////                print("error=\(error)")
////                return
////            }
//           // hideLoadingHUD(for_view: self.appDelegate.window!)
//            if response != nil {
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                if statusCode == 400 {
//                    failureHandler("Error")
//                    print("error=\(String(describing: error))")
//
//
//                }
//                if statusCode == 404 {
//                    failureHandler("Error")
//                    print("error=\(String(describing: error))")
//                    // self.appDelegate.window?.makeToast("\(String(describing: error))", duration:kToastDuration , position:.center)
//                    //                        self.appDelegate.showAlert(alertTitle: "Alert!", aleertMessage: "\(String(describing: error))")
//
//
//                }
//                if statusCode == 401 {
//                    failureHandler("unAuthorized")
//                }
//                if statusCode == 500 {
//                    print("failuer 1")
//                    failureHandler("unAuthorized")
//                }
//                if statusCode == 200 {
//                    do {
//                        let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
//                        print(parsedData)
//                        successHandler(parsedData as AnyObject)
//                    } catch let error as NSError {
//                        print("error=\(error)")
//                        return
//                    }
//                }else{
//                    print("Faild response = \(String(describing: statusCode))")
//
//                }
//            }
//            print("responseString = \(String(describing: response))")
//        }
//        task.resume()
//    }
//}
//class Service: NSObject {
//
//    
//    static let shareInstance = Service()
//    
//    func getAllMovieData(baseurl : String ,completion: @escaping(HomeJsonVo?, Error?) -> ()){
//        let urlString = "https://socialmediaallinone.com/sma_admin/rest-api/v100/home_content_for_android"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let err = error{
//                completion(nil,err)
//                print("Loading data error: \(err.localizedDescription)")
//            }else{
//                guard let data = data else { return }
//                do{
//                    var arrMovieData = [HomeJsonVo]()
//                    let results = try JSONDecoder().decode(HomeJsonVo.self, from: data)
////                    for movie in results.results{
////                        arrMovieData.append(MovieModel(artistName: movie.artistName!, trackName: movie.trackName!))
////                    }
//                    completion(results, nil)
//                }catch let jsonErr{
//                    print("json error : \(jsonErr.localizedDescription)")
//                }
//            }
//        }.resume()
//    }
//    
//    
//    
//}
