//
//  ContactUSViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 15/04/22.
//

import UIKit
import ObjectMapper
import JGProgressHUD
import AFNetworking
import CoreLocation
import Alamofire
import MessageUI

class ContactUSViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var cancel_btn: UIButton!
    
    @IBOutlet weak var txf_email: UITextField!
    @IBOutlet weak var txf_name: UITextField!
    @IBOutlet weak var txtview: UITextView!
    
    
    @IBOutlet weak var lbl_Address: UILabel!
    
    @IBOutlet weak var txtview_one: UITextView!
    @IBOutlet weak var txtview_two: UITextView!
    @IBOutlet weak var txtview_three: UITextView!
    
    @IBOutlet weak var txtview_email: UITextView!
    
    @IBOutlet weak var save_btn: UIButton!
    @IBOutlet weak var location_btn: UIButton!
    @IBOutlet weak var phone_btn: UIButton!
    @IBOutlet weak var email_btn: UIButton!
    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var backview2: UIView!
    
    @IBOutlet weak var backview3: UIView!
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var imgview: UIImageView!
    let imageData = Data()
     var yournameStr = ""
     var emailStr = ""
     var descriptionStr = ""
     var PhotoStr = ""
   
    var loginPhoneNumber = ""
     var activeTextFiled = UITextField()
    
     let hud = JGProgressHUD()
    
    var EnquiryformJsonVOArr:[StateListJsonVO] = Array<StateListJsonVO>()
    var EnquiryResultVOArr:[StateResultVO] = []

    var imagePicker = UIImagePickerController()
    
    var selectedImageArray = [UIImage]()
   
//    let formattedNumber = phoneNumberVariable.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
    
    let locationManager = CLLocationManager()
    
    
    var filesarray = [String]()
          var attatched_image = [UIImage]()
          var attatched_file_names = [String]()
          var filedata : Data?
          var filename : String?
          var pdf_url = [URL]()
          var url_pdf = [URL]()
          var pdf_file_names = [String]()
          var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
//        self.locationManager.requestAlwaysAuthorization()
       
        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()

//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        
        
        txtview_one.isEditable = false
        txtview_two.isEditable = false
        txtview_three.isEditable = false
        txtview_email.isEditable =  false
        
        txf_name.text = yournameStr
        txf_email.text = emailStr
        txtview.text = descriptionStr
        
        txf_name.delegate = self
        txf_email.delegate =  self
        txtview.delegate =  self
        
        txtview.text = "Add discription..."
        txtview.textColor = UIColor.lightGray
        self.setup()
    }
    func setup(){
        
        mainview.layer.cornerRadius = 6
        mainview.layer.borderWidth = 1
        mainview.layer.borderColor = UIColor.lightGray.cgColor
        
        backview.layer.cornerRadius = 6
        backview.layer.borderWidth = 1
        backview.layer.borderColor = UIColor.lightGray.cgColor
        
        backview2.layer.cornerRadius = 6
        backview2.layer.borderWidth = 1
        backview2.layer.borderColor = UIColor.lightGray.cgColor
        
        backview3.layer.cornerRadius = 6
        backview3.layer.borderWidth = 1
        backview3.layer.borderColor = UIColor.lightGray.cgColor
        
        save_btn.layer.cornerRadius = 6
        save_btn.layer.borderWidth = 1
        save_btn.layer.borderColor = UIColor.clear.cgColor
        
        let loginUserId = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        
        getprofileAPI(loginuserid: loginUserId)
    }
    func getprofileAPI(loginuserid: String) {
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/user_details_by_user_id?id=" + "" + loginuserid
        
        
        print(url)

        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            //            print("responseObject",responseObject)
            let respVO:GetProfileVO = Mapper().map(JSONObject: responseObject)!
            if respVO.status == "success" {
                self.loginPhoneNumber = respVO.phone ?? ""
            }else{
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()
        textField.endEditing(true)
        //        textField.endEditing(true)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if txtview.textColor == UIColor.lightGray {
            txtview.text = ""
            txtview.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if txtview.text == "" {
            txtview.text = "Add discription..."
            txtview.textColor = UIColor.black
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextFiled = textField
        if activeTextFiled.tag == 200 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 201 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 202 {
            textField.inputView = nil
            textField.keyboardType = .numberPad
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextFiled.tag == 200 {
            self.yournameStr = textField.text!
            UserDefaults.standard.set(self.yournameStr, forKey: "name")
        }else if activeTextFiled.tag == 201 {
            self.emailStr = textField.text!
        UserDefaults.standard.set(self.emailStr, forKey: "email")
        }else if activeTextFiled.tag == 202 {
            self.descriptionStr = textField.text!
            UserDefaults.standard.set(descriptionStr, forKey: "Discription")
        }
    }
    
    
    @IBAction func cancel_btnActn(_ sender: UIButton) {
    }
    
    @IBAction func save_btnActn(_ sender: UIButton) {
        
        self.txf_email.endEditing(true)
        self.txf_name.endEditing(true)
        self.txtview.endEditing(true)
    

        
        let emailStr = txf_email.text
        let yournameStr = txf_name.text
        let descriptionStr = txtview.text
    
        
         if emailStr == "" {
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter email")
        } else if yournameStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter name")
        }else if descriptionStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please EnterDISCRIP")
        }else{
            EnquiryForm()
        }
    }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func location_BtnActn(_ sender: UIButton) {
    }
    
    
    @IBAction func phone_BtnActn(_ sender: UIButton) {
        
    }
   


    
    @IBAction func email_BtnActn(_ sender: UIButton) {
        
        //TODO:  You should chack if we can send email or not
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["rajubhai4745@gmail.com"])
            mail.setSubject("Email Subject Here")
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Application is not able to send an email")
        }
        
        
    }
    
    
    @IBAction func camera_BtnActn(_ sender: UIButton) {
//        openGallary()
        imageCaptuer()
    }
    //MARK: SUBMIT
//    func SubmitUser() {
//        hud.textLabel.text = "Loading"
//         hud.show(in: self.view)
//         
//         let parameters:NSMutableDictionary = NSMutableDictionary()
// //        let phone_number = UserDefaults.standard.object(forKey:"phone") as? String ?? ""
// //        loginPhoneNumber = phone_number
//        
//         let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/enquiryform"
//         
//         parameters["name"] = txf_name.text
//         parameters["email"] = txf_email.text
//         parameters["description"] = txtview.text
//         parameters["phone"] = loginPhoneNumber
//         parameters["photo"] = ""
//         
//         print(url)
//        print(url)
//        var Timestamp: String {
//            return "\(NSDate().timeIntervalSince1970 * 1000)"
//        }
//        let compression = 0.5
//        
//        
//        
////        if imageData != nil{
////            let manager = AFHTTPSessionManager()
////            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>
////
////
////            manager.post(url, parameters: parameters, headers: nil, constructingBodyWith: { [self] (formData : AFMultipartFormData!) in
////                var keyName = String()
////                for (index ,image) in self.imageData.enumerated(){
////
////                    if index == 0{
////                        keyName = "photo"
////                    }
////                let imageDataaa = image.jpegData(compressionQuality: CGFloat(compression))
////                    formData.appendPart(withFileData: imageData, name: keyName, fileName: "\(Timestamp)_image.jpg", mimeType: "image/jpg")
////                }
////            }, progress: nil, success: { (operation,responseObject) in
////                print(responseObject as Any)
////                let result = responseObject as! NSDictionary
////
////                let status = result.value(forKey:"status") as?  Int ?? 0
////
////                if status == 0 {
//////                    self.loader.stopAnimating()
//////                    self.showAlert(alertTitle: "self", message: "Sorry... Something went wrong.")
////                    return
////                }
////
////            }) { (operation, error) in
////                print("Error: " + error.localizedDescription)
//////                self.loader.stopAnimating()
//////                self.showAlert(alertTitle: "self", message: error.localizedDescription)
////            }
////        }
//    }
    
    
    func EnquiryForm(){

        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
                let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/enquiryform"
        let parameters:NSMutableDictionary = NSMutableDictionary()

        
        parameters["name"] = txf_name.text
                parameters["email"] = txf_email.text
                parameters["description"] = txtview.text
                parameters["phone"] = loginPhoneNumber
                parameters["photo"] = ""
                
        
      //  let paramDic = ["name":txf_name.text,"email":txf_email.text,"description":txtview.text,"phone":loginPhoneNumber,"photo":""] as [String : String]
        
        APIManager.sharedInstance.agentWiseHistory(urlString: url ,file: attatched_file_names.removeDuplicatesData(), image: attatched_image.removeDuplicatesData(), url:url_pdf.removeDuplicatesData(), parameters: parameters as! [String : String]) { (result) in
            print(result)
            print(result as Any)
            self.hud.dismiss()
            
            
            
        } failure: { (error, status) in
            print(error)
            self.hud.dismiss()
           // self.loginShowAlert(alertTitle: "Alert!", message: error?.localizedDescription ?? "", statusCode: "0")


        }
    }
    func EnquiryForm1() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let parameters:NSMutableDictionary = NSMutableDictionary()
//        let phone_number = UserDefaults.standard.object(forKey:"phone") as? String ?? ""
//        loginPhoneNumber = phone_number
       
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/enquiryform"
        
        parameters["name"] = txf_name.text
        parameters["email"] = txf_email.text
        parameters["description"] = txtview.text
        parameters["phone"] = loginPhoneNumber
        parameters["photo"] = ""
        
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>
        manager.post(url, parameters: parameters, headers: ["API-KEY" : "8e90d71140a94bb"], constructingBodyWith: { (formData : AFMultipartFormData!) in
            
        }, progress: nil, success: { [self] (operation,enqueryResult) in
            let respVO:GetProfileVO = Mapper().map(JSONObject: enqueryResult)!
            let statusCode = respVO.code
            
            if statusCode == 200 {
                self.loginShowAlert(alertTitle: "Alert!", message: respVO.data ?? "")
            }else{
                
            }
            self.hud.dismiss()
            
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
            self.hud.dismiss()
            self.loginShowAlert(alertTitle: "Alert!", message: error.localizedDescription)
        }        //  }
        
    }
    func loginShowAlert(alertTitle : String, message : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    func optionsForUploadPhoto(sender : Any ) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }

}
//MARK: - UIImagePickerControllerDelegate

extension ContactUSViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imageCaptuer(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Please Select Photo", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                imagePicker.title = "YourChoice"
                imagePicker.allowsEditing = false
                print(imagePicker.cameraCaptureMode.hashValue)
                print(imagePicker.cameraCaptureMode.rawValue)
                self.present(imagePicker, animated: true, completion: nil)
            }else{
                print("Camera Not available......")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad
        present(actionSheet, animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // picker.dismiss(animated: true, completion: nil)
        // let image = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        //     if #available(iOS 11.0, *) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            print("imageData",imgName)
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            
            self.attatched_image.append(selectedImage)
            self.imgview.image = selectedImage
            
            let imageData = selectedImage.pngData()

            
            print("selectedImage",selectedImage)
          //  self.img_view.image = selectedImage
           
        }else{
            
            // let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            self.attatched_image.append(selectedImage)
            self.imgview.image = selectedImage
           // self.isChangeImage = true
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //MARK: - location delegate methods
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation :CLLocation = locations[0] as CLLocation
//
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")
//
//        //        self.labelLat.text = "\(userLocation.coordinate.latitude)"
//        //        self.labelLongi.text = "\(userLocation.coordinate.longitude)"
//
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
//            if (error != nil){
//                print("error in reverseGeocode")
//            }
//            let placemark = placemarks! as [CLPlacemark]
//            if placemark.count>0{
//                let placemark = placemarks![0]
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
//
//                self.lbl_Address.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
//            }
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error \(error)")
//    }
    
}



extension ContactUSViewController : MFMailComposeViewControllerDelegate {
    //MARK: MFMail Compose ViewController Delegate method
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
}
