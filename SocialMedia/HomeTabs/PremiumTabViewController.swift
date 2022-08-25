//
//  PremiumTabViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit
import ObjectMapper
import AFNetworking
import JGProgressHUD
import SDWebImage
import Razorpay


class PremiumTabViewController: UIViewController {
//
    
    @IBOutlet weak var lbl_headerTitle: UILabel!
    
    
    @IBOutlet weak var lbl_discription: UILabel!
    
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    @IBOutlet weak var primium_collectionview: UICollectionView!
    
    var selectedSegmantType = ""
    var imageArray = ["sliver_back","red_back","sliver_back","orange_back"]
    var filtered:[AllPakResultVO] = []
    var videosJsonVO:[PakResultVO] = []
    var videosJsonVO2:[PakResultVO] = []
    var videosJsonVO3:[PakResultVO] = []
    var yourSelectedIndex:[PakResultVO] = []

    var selctedtype = ""
    
    // typealias Razorpay = RazorpayCheckout

   var razorpay: RazorpayCheckout!
   var razorpayTestKey = ""
   var razorpayId = String()
    
    var selectedName = ""
    var selectedPriece = ""
    var totall = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)

        primium_collectionview.delegate = self
        primium_collectionview.dataSource =  self
        primium_collectionview.register(UINib(nibName: "DummyPrimiumCell", bundle: nil), forCellWithReuseIdentifier: "DummyPrimiumCell")
        lbl_discription.font = UIFont.systemFont(ofSize: CGFloat(25))


        selectedSegment.selectedSegmentIndex = 0
       

        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""

        getPremiumAPI(loginuserid: loginUserid)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        razorpay = RazorpayCheckout.initWithKey("rzp_live_kEsm9BEn2tT49r", andDelegate: self)
    }
//    internal func showPaymentForm(){
//        let options: [String:Any] = [
//                    "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
//                    "currency": "INR",//We support more that 92 international currencies.
//                    "description": "purchase description",
//                    "order_id": "order_DBJOWzybf0sJbb",
//                    "image": "SocialMedia",
//                    "name": "Social Media-All in one",
//                    "prefill": [
//                    "contact": "",
//                    "email": ""
//                    ],
//                    "theme": [
//                    "color": "#F37254"
//                    ]
//                ]
//        razorpay.open(options)
//    }
    
    
    private func showPaymentForm(){
        let contact = UserDefaults.standard.value(forKey:"phone") as? String ?? ""
        let email = UserDefaults.standard.value(forKey:"email") as? String ?? ""
        let totall = selectedPriece.doubleValue * 100
        
//        let orderId = arc4random_uniform(900000) + 100000;
       
//        "name": "Bronze",
//       "price": "300",
        
        let options: [String:Any] = [
                    "amount": totall, //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": selectedName,
//                   "order_id": "selectedPriece",
                    "image": "http://socialmediaallinone.com/assets/images/logo.png",
                    "name": "Social Media-All in one",
                    "prefill": [
                    "contact": String(contact),
                    "email": String(email)
                    ],
                    "theme": [
                        "color": "#F37254"
                    ]
                ]
        razorpay.open(options)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func updateAPICall(){
//        //        getRequest(with: URL(string: "https://socialmediaallinone.com/sma_admin/rest-api/v100/home_content_for_android")!) { (result) in
//        getRequest(with: URL(string: "https://socialmediaallinone.com/sma_admin/rest-api/v100/all_package")!) { (result) in
//
//            //  print("Result",Result)
//            let respVO:AllPakJsonVO = Mapper().map(JSONObject: result)!
//
//            let listArr = respVO.pkg
//            self.filtered = listArr!
//            print("self.filteredself.filtered",self.filtered.count,self.filtered)
//
//            self.filtered = listArr!
//            for eachArray in self.filtered{
//
//                if eachArray.name == "General Used"{
//                    self.videosJsonVO = eachArray.package_data!
//                    print("self.videosJsonVOOne",self.videosJsonVO.count)
//                }
//                if eachArray.name == "Business Used"{
//                    self.videosJsonVO2 = eachArray.package_data!
//                    print("videosJsonVO2",self.videosJsonVO2.count)
//
//                }
//                if eachArray.name == "Political Used"{
//                    self.videosJsonVO3 = eachArray.package_data!
//                    print("videosJsonVO3",self.videosJsonVO3.count)
//
//                }
//                // print("eachArray",eachArray)
//            }
//
//            DispatchQueue.main.async {
//                if self.selectedSegment.selectedSegmentIndex == 0 {
//                    self.yourSelectedIndex = self.videosJsonVO
//                }
//                self.primium_collectionview.reloadData()
//            }
//
//        }
//    }
    func getPremiumAPI(loginuserid: String) {
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/all_package?user_id=" + "" + loginuserid
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            //            print("responseObject",responseObject)
            //            let respVO:GetProfileVO = Mapper().map(JSONObject: responseObject)!
            //            if respVO.status == "success" {
            
            
            //  print("Result",Result)
            let respVO:AllPakJsonVO = Mapper().map(JSONObject: responseObject)!
            
            let listArr = respVO.pkg
            self.filtered = listArr!
            print("self.filteredself.filtered",self.filtered.count,self.filtered)
            
            self.filtered = listArr!
            for eachArray in self.filtered{
                
                //                    if eachArray.name == "General Used"{
                self.lbl_headerTitle.text = eachArray.name ?? ""
                self.videosJsonVO = eachArray.package_data!
                
                for all in self.videosJsonVO {
                    let selectedText =  all.description ?? ""
                    self.lbl_discription.attributedText = selectedText.htmlAttributedString()
                    

                }
                print("self.videosJsonVOOne",self.videosJsonVO.count)
                
                
                //                    }
                //                    if eachArray.name == "Business Used"{
                //                        self.videosJsonVO2 = eachArray.package_data!
                //                        print("videosJsonVO2",self.videosJsonVO2.count)
                //
                //                    }
                //                    if eachArray.name == "Political Used"{
                //                        self.videosJsonVO3 = eachArray.package_data!
                //                        print("videosJsonVO3",self.videosJsonVO3.count)
                //
                //                    }
                // print("eachArray",eachArray)
                
            }
            
            DispatchQueue.main.async {
                if self.selectedSegment.selectedSegmentIndex == 0 {
                    self.yourSelectedIndex = self.videosJsonVO
                }
                self.primium_collectionview.reloadData()
            }
            
        } failure: {operation, error in
            print("error",error)
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
            primium_collectionview.tintColor = .red
        } else {
            // Fallback on earlier versions
        }
        switch selectedSegment.selectedSegmentIndex {
        case 0:
//          self.yourSelectedIndex = self.videosJsonVO
            self.yourSelectedIndex = self.videosJsonVO3
            primium_collectionview.reloadData()
        case 1:
            self.yourSelectedIndex = self.videosJsonVO2
            primium_collectionview.reloadData()
        case 2:
//          self.yourSelectedIndex = self.videosJsonVO3
            self.yourSelectedIndex = self.videosJsonVO
            primium_collectionview.reloadData()
        default:
            break
        }
    }
    
}
extension PremiumTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return self.yourSelectedIndex.count
        return self.videosJsonVO.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "DummyPrimiumCell", for:  indexPath) as! DummyPrimiumCell
        
        //        cell.lbl_titlename.text = "\(self.yourSelectedIndex[indexPath.item].name ?? 0)"
        
        cell.lbl_titlename.text = self.videosJsonVO[indexPath.item].name ?? ""
        cell.lbl_daycount.text = self.videosJsonVO[indexPath.item].day
        cell.lbl_proece.text = self.videosJsonVO[indexPath.item].price ?? ""
        cell.lbl_mrp.text = self.videosJsonVO[indexPath.item].mrp ?? ""
        cell.lbl_disscount.text = "Save \(self.videosJsonVO[indexPath.item].discount ?? "0")"
        cell.imgview.image = UIImage(named: imageArray[indexPath.row])
        
        
        
        //        cell.lbl_name.text = yourSelectedIndex[indexPath.row]
        //        cell.imgview.image = UIImage(named: yourSelectedIndex[indexPath.row])
        
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
        
        //            return CGSize(width: 100, height: 230)
        return CGSize(width: 180, height: 356)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

//        "name": "Bronze",
//        "price": "300",
        
        selectedName = videosJsonVO[indexPath.item].name ?? ""
        selectedPriece = videosJsonVO[indexPath.item].price ?? ""
        
        let yourSelectedDescription = self.videosJsonVO[indexPath.item].description ?? ""
        lbl_discription.attributedText = yourSelectedDescription.htmlAttributedString()
        self.showPaymentForm()
    }
    
    
}

// Razor Pay Payment Method Integration

extension PremiumTabViewController : RazorpayPaymentCompletionProtocol {

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        
//        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        razorpayId = String(payment_id)
        self.showAlert(alertTitle: "Success", message: "Payment Succeeded")
    }
}
extension PremiumTabViewController: RazorpayPaymentCompletionProtocolWithData {

    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        
        showAlert(alertTitle : "SocialMedia", message : "String")
//       / /self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.showAlert(alertTitle: "Success", message: "Payment Succeeded")
    }
}
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}
extension UILabel {
    func setSizeFont (sizeFont: Double) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}
extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}
