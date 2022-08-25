//
//  SampleViewController.swift
//  SocialMedia
//
//  Created by Abdul on 10/05/22.
//

import UIKit
import ObjectMapper
import SDWebImage


class SampleViewController: UIViewController {
    
    var selectedSegmantType = ""
    
    @IBOutlet weak var lbl_discription: UILabel!
    @IBOutlet weak var premimum: UISegmentedControl!
    
    @IBOutlet weak var premium: UICollectionView!
    
    var filtered:[AllPakResultVO] = []
    var videosJsonVO:[PakResultVO] = []
    var videosJsonVO2:[PakResultVO] = []
    var videosJsonVO3:[PakResultVO] = []
    var yourSelectedIndex:[PakResultVO] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        premium.delegate = self
        premium.dataSource =  self
        premium.register(UINib(nibName: "PremiumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PremiumCollectionViewCell")
//        if premimum.selectedSegmentIndex == 0 {
//            updateAPICall()
//        }else{
        premimum.selectedSegmentIndex = 0

            updateAPICall()
      //  }
    }
    
    func updateAPICall(){
        //        getRequest(with: URL(string: "https://socialmediaallinone.com/sma_admin/rest-api/v100/home_content_for_android")!) { (result) in
        getRequest(with: URL(string: "https://socialmediaallinone.com/sma_admin/rest-api/v100/all_package")!) { (result) in
            
            //  print("Result",Result)
            let respVO:AllPakJsonVO = Mapper().map(JSONObject: result)!
            
            let listArr = respVO.pkg
            self.filtered = listArr!
            print("self.filteredself.filtered",self.filtered.count,self.filtered)
            
            self.filtered = listArr!
            for eachArray in self.filtered{
                
                if eachArray.name == "General Used"{
                    self.videosJsonVO = eachArray.package_data!
                    print("self.videosJsonVOOne",self.videosJsonVO.count)
                }
                if eachArray.name == "Business Used"{
                    self.videosJsonVO2 = eachArray.package_data!
                    print("videosJsonVO2",self.videosJsonVO2.count)
                    
                }
                if eachArray.name == "Political Used"{
                    self.videosJsonVO3 = eachArray.package_data!
                    print("videosJsonVO3",self.videosJsonVO3.count)
                    
                }
                // print("eachArray",eachArray)
            }
            
            DispatchQueue.main.async {
                if self.premimum.selectedSegmentIndex == 0 {
                    self.yourSelectedIndex = self.videosJsonVO
                }
                self.premium.reloadData()
            }
            
        }
    }
    func getRequest(with url: URL, callback: @escaping (Any?) -> Swift.Void) -> Void {
            
            let defaultConfigObject = URLSessionConfiguration.default
            defaultConfigObject.timeoutIntervalForRequest = 30.0
            defaultConfigObject.timeoutIntervalForResource = 60.0
            
            let session = URLSession.init(configuration: defaultConfigObject, delegate: nil, delegateQueue: nil)
            
            var urlRequest = URLRequest(url: url as URL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("8e90d71140a94bb", forHTTPHeaderField: "API-KEY")
            
            
            urlRequest.httpMethod = "GET"
            session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                guard    let httpResponse: HTTPURLResponse = response as? HTTPURLResponse
                    else {
                        print("Error: did not receive data")
                        return
                }
                
                var response : (Any)? = nil
                
                if httpResponse.statusCode == 200 {
                    print(httpResponse)
                    
                    guard let responseData = data else {
                        print("Error: did not receive data")
                        return
                    }
                    
                    do {
                        let responseData = try JSONSerialization.jsonObject(with: responseData, options: [JSONSerialization.ReadingOptions.allowFragments])
                        
                        response = responseData
                        print("response",response)
                        callback(response)
                    }
                    catch _ as NSError {
                        
                        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        callback(responseString)
                        return
                    }
                }
                else {
                    print(httpResponse)
                    
                    guard error == nil else {
                        print("error calling GET on /todos/1")
                        print(error ?? "error")
                        callback(response!)
                        return
                    }
                    
                }
            }).resume()
        }
    @IBAction func segmented(_ sender: UISegmentedControl) {

        if #available(iOS 13.0, *) {
            premimum.tintColor = .red
        } else {
            // Fallback on earlier versions
        }
        switch premimum.selectedSegmentIndex {
        case 0:
            self.yourSelectedIndex = self.videosJsonVO
            premium.reloadData()
        case 1:
            self.yourSelectedIndex = self.videosJsonVO2
            
            premium.reloadData()
        case 2:
            self.yourSelectedIndex = self.videosJsonVO3
            premium.reloadData()
        default:
            break
        }
    }
    
}
extension SampleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.yourSelectedIndex.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "PremiumCollectionViewCell", for:  indexPath) as! PremiumCollectionViewCell
        cell.lbl_title.text = self.yourSelectedIndex[indexPath.item].plan_id ?? ""
        cell.lbl_months.text = self.yourSelectedIndex[indexPath.item].discount ?? ""

//        cell.lbl_name.text = MainArrayList[indexPath.row]
//        cell.imgview.image = UIImage(named: ImagemainArrayList[indexPath.row])
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 100, height: 186)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let yourSelectedDescription = self.yourSelectedIndex[indexPath.item].description ?? ""
        
        self.lbl_discription.text = yourSelectedDescription
        
        
        //lbl_discription.attributedText = yourSelectedDescription.htmlAttributedString()

        self.premium.reloadData()
        //description
//        if indexPath.item == 0 {
//            
//        }else{
//            
//        }
     
    }
    
}
//extension String {
//    func htmlAttributedString() -> NSAttributedString? {
//        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
//        guard let html = try? NSMutableAttributedString(
//            data: data,
//            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil) else { return nil }
//        return html
//    }
//}
