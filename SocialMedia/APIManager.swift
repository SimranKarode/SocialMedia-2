//
//  APIManager.swift


import Foundation
import UIKit
import Alamofire
import JGProgressHUD

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    //TODO :-
    /* Handle Time out request alamofire */
  //  let reachability = Reachability()!
    var appDelegate = AppDelegate()
    let content_type = "application/json; charset=utf-8"
    //"Content-type": "multipart/form-data"
    
//    let hud = JGProgressHUD()

    func agentWiseHistory(urlString: String,file : [String],image : [UIImage],url: [URL],parameters: [String : String], success:@escaping(Any)->(), failure: @escaping(Error?,Int?)->()){
//        SVProgressHUD.show(withStatus:"Loding")

        let delegateV = UIApplication.shared.delegate as? AppDelegate
        let headers = ["Content-Type" : "multipart/form-data","API-KEY" : "8e90d71140a94bb"]
        let completeurl = urlString

        let urlStr = completeurl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let urlString = URL(string: urlStr)
        let urls = urlString
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key as String)
            }
            var imagedata = [Data]()
            for uiimage in image{
                let imgdata = uiimage.jpegData(compressionQuality: 1.0)
                if imgdata != nil {
                    imagedata.append(imgdata!)
                }
            }
            let count = imagedata.count
            for i in 0..<count{
                let img = image[i]
                let imgdata = img.jpegData(compressionQuality: 1.0)
//                multipartFormData.append(imgdata!, withName: ".file", fileName: file[i] , mimeType: "image/jpeg")
                multipartFormData.append(imgdata!, withName: "photo", fileName: "photo" , mimeType: "image/jpeg")

                //photo      
            }
            var pdf_data = Data()
            var filename = String()
            for URL in url{
                do {
                    let pdfdata = try Data(contentsOf: URL)
                    pdf_data = pdfdata
                    print(pdf_data)
                } catch {
                    print("Unable to load data: \(error)")
                }
                filename = URL.lastPathComponent
                multipartFormData.append(pdf_data, withName: "photo", fileName: filename, mimeType:"application/pdf")
            }
        },to: urls!, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error,404)
                    }
                }
            case .failure(let error):
                failure(error,404)
            }
        }
    }

}


extension Array where Element:Equatable {
    func removeDuplicatesData() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
extension NSMutableAttributedString {

@discardableResult func boldTitle(_ text:String , _ color:UIColor) -> NSMutableAttributedString {
      let attrs : [NSAttributedString.Key : Any] = [
          NSAttributedString.Key.font : UIFont(name: "HelveticaNeue_bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16),
          NSAttributedString.Key.foregroundColor :color]
      let boldString = NSMutableAttributedString(string: text, attributes: attrs)
      self.append(boldString)
      return self
  }
    @discardableResult func normalTitle(_ text:String, _ color:UIColor)->NSMutableAttributedString {
            let attrs : [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.font : UIFont(name: "HelveticaNeue_reg", size: 16) ?? UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor :color
            ]
            let normal =  NSAttributedString(string: text,  attributes:attrs)
            self.append(normal)
            return self
        }
}


