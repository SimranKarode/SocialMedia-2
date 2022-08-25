//
//  MyProfileViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 19/04/22.
//

import UIKit
import JGProgressHUD
import ObjectMapper
import AFNetworking


class MyProfileViewController: UIViewController,UITextFieldDelegate,ToolbarPickerViewDelegate {
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var txf_name: UITextField!
    @IBOutlet weak var txf_email: UITextField!
    @IBOutlet weak var txf_mobileNumber: UITextField!
    @IBOutlet weak var txf_companyName: UITextField!
    @IBOutlet weak var txf_companyAddress: UITextField!
    @IBOutlet weak var txf_website: UITextField!
    @IBOutlet weak var edit_btn: UIButton!
    @IBOutlet weak var txf_selected: UITextField!
    
    @IBOutlet weak var save_btn: UIButton!
    
    
    var loginuserid = ""
    var loginUserName = ""
    var loginPhoneNumber = ""
    
     var yournameStr = ""
     var emailStr = ""
     var phoneNumberStr = ""
    
     var companyNameStr = ""
     var companyAddStr = ""
     var webisteStr = ""
     var SelectedStr = ""
    
     var activeTextFiled = UITextField()
    
     let hud = JGProgressHUD()
    
    fileprivate let pickerView = ToolbarPickerView()
    fileprivate let routeArray = ["Manager", "HR", "Network", "IT"]
    var designationNumberArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","12","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93"]
    var designationNameArray = ["Real Estate","Marble & CVeramic","Clothes Business","Daily & Sweets Store","Daily & Sweets Store","Electrical Services Provider","FMCG & Grocery","Hardware & Sanitaryware","Tours & Travels","Wood Buisness","Resaurant,Cafe & Catering","Furniture","Advocate","Automobile Business","Agriculture Business","Chartered Accountant","Chemical","Clinic & Hospital","Storage & Warehouse","Cosmetic Store","Education Business","Education Business","Education Business","Event Agency","Loan & Finance","Fire Safety","Flower","Electronics","Fruits & Vegetable","Goggles & Spectacles","Graphics Designing","Gym & Yoga","Home Appliances","Home Automation","Other","Import & Export","Interior Maker","Jewellery","Lighting Business","Man Power  Provider","Pharmaceutical","Photographer","Politics","Printing Service Provider","Security Surveillance Service(CCTV)","Social Activities","Solar & Power Panel","Sport Academy","Stationery Store","Steel and Aluminumn Business","Tailor","Textile Industry","Gift Articles & Toys","Cycles","Consultant","Dental","Salon, Spa & Beauty Parlour","Mechanical Garage","Stationery Store","Doctor","Astrologer","Ayurvedic","Hotel","Immigration Visa Consultant","Insurance","Laundry Dry Cleaner","Marketing Agency","Musical Business","Packaging","Painting & Color Services","Petrol Pump","RO Water","Mobile Sales & Repair","Car Towing & Crane Service","IT & Software","Industrial Oils & Grease","Pump Sales Services","Nursery","Electric Bikes","Internet Service Provider","Animal Food","Civil Contractor","Dance Class Academy","Watch Manufacturing & Store","Housekeeping & Cleaning","BJP - Bharatiy Janta Party","Idian National Congress","AAP - Aam Aadmi Party","Shiv Sena Party","Samajwadi Party","Footware Store","Tyre","Stock Market Advisor","Diamond","Incense Sticks","Vehicle GPS Tracker","Helth Care"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        imgview.layer.borderWidth = 1
        imgview.layer.masksToBounds = false
        imgview.layer.borderColor = UIColor.black.cgColor
        imgview.layer.cornerRadius = imgview.frame.width/2
        imgview.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        loginuserid = loginUserid

        
        txf_name.text = yournameStr
        txf_email.text = emailStr
        txf_mobileNumber.text = phoneNumberStr

        
        txf_name.delegate = self
        txf_email.delegate = self
        txf_mobileNumber.delegate = self
        txf_companyName.delegate = self
        txf_companyAddress.delegate = self
        txf_website.delegate = self
        txf_selected.delegate = self
        
        activeTextFiled.delegate = self
        txf_mobileNumber.isUserInteractionEnabled = false

        txf_name.tag = 100
        txf_email.tag = 101
        txf_mobileNumber.tag = 102
        txf_companyName.tag = 103
        txf_companyAddress.tag = 104
        txf_website.tag = 105
        txf_selected.tag = 106
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextFiled = textField
        if activeTextFiled.tag == 100 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 101 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 102 {
            textField.inputView = nil
            textField.keyboardType = .numberPad
        }else if activeTextFiled.tag == 103 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 104 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 105 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 106 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextFiled.tag == 100 {
            self.yournameStr = textField.text!
            UserDefaults.standard.set(self.yournameStr, forKey: "name")
        }else if activeTextFiled.tag == 101 {
            self.emailStr = textField.text!
        UserDefaults.standard.set(self.emailStr, forKey: "email")
        }else if activeTextFiled.tag == 102 {
            self.phoneNumberStr = textField.text!
            UserDefaults.standard.set(phoneNumberStr, forKey: "phone")
        }else if activeTextFiled.tag == 103 {
            self.companyNameStr = textField.text!
            UserDefaults.standard.set(companyNameStr, forKey: "CompanyName")
        }else if activeTextFiled.tag == 104 {
            self.companyAddStr = textField.text!
            UserDefaults.standard.set(companyAddStr, forKey: "CompanyAddress")
        }else if activeTextFiled.tag == 105 {
            self.webisteStr = textField.text!
            UserDefaults.standard.set(webisteStr, forKey: "Web")
        }else if activeTextFiled.tag == 106 {
            self.SelectedStr = textField.text!
            UserDefaults.standard.set(SelectedStr, forKey: "Designation")
        }
    }
    

    // MARK: - KeyBoard Handiling
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
          textField.resignFirstResponder()
            textField.endEditing(true)
            return true
        }
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true )
    }
    
   
    @IBAction func edit_BtnActn(_ sender: UIButton) {
        imageCaptuer()
    }
    

    @IBAction func save_BtnActn(_ sender: UIButton) {
        
        UserDefaults.standard.set(imgview.image?.pngData(), forKey: "ProfilPic")
        
        self.txf_name.endEditing(true)
        self.txf_email.endEditing(true)
        self.txf_mobileNumber.endEditing(true)
        self.txf_companyName.endEditing(true)
        self.txf_companyAddress.endEditing(true)
        self.txf_website.endEditing(true)
        self.txf_selected.endEditing(true)


        let yournameStr = txf_name.text
        let emailStr = txf_email.text
        let phoneNumberStr = txf_mobileNumber.text
        let companyNameStr = txf_companyName.text
        let companyAddStr = txf_companyAddress.text
        let webisteStr = txf_website.text
        let SelectedStr = txf_selected.text
        

        if yournameStr == "" {
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Name")
        } else if emailStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Emil")
        }else if phoneNumberStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter PhoneNumber")
        }else if companyNameStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter CompanyName")
        }else if companyAddStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Company Address")
        }else if webisteStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Website")
        }else if SelectedStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Desigination")
        }else{
            UpdateProfile()
        }
    }
    
   
    func UpdateProfile() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let parameters:NSMutableDictionary = NSMutableDictionary()
       
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/update_profile2"
        parameters["id"] = loginuserid
        parameters["name"] = yournameStr
        parameters["email"] = emailStr
        parameters["phone"] = phoneNumberStr
        parameters["company_name"] = companyNameStr
        parameters["adress"] = companyAddStr
        parameters["website"] = webisteStr
        parameters["business_type"] = SelectedStr
        
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        
        manager.post(url, parameters: parameters, headers: ["API-KEY" : "8e90d71140a94bb"], constructingBodyWith: { (formData : AFMultipartFormData!) in
            
        }, progress: nil, success: { [self] (operation,LoginResponse) in
            print(LoginResponse as Any)
            let result = LoginResponse as! NSDictionary
            
            let status = result["status"] as? String
            let data = result["data"] as? String
            let image_url = result["image_url"] as? String
            
            
            print("datadata",data)
            UserDefaults.standard.set(status, forKey: "status")
           
            
            if status == "success" {
                
                self.loginShowAlert(alertTitle: "Alert!", message: data ?? "")
                
                
            }else{
                self.loginErrorShowAlert(alertTitle: "Alert!", message: data ?? "")

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
            self.homeTonaviation()
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func loginErrorShowAlert(alertTitle : String, message : String)
       {
           let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
           
           let OKAction = UIAlertAction(title: "OK", style: .default) { action in
               //            print("You've pressed OK Button")
           }
           
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    func homeTonaviation(){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateBussinessProfileViewController") as! UpdateBussinessProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
//        UpdateBussinessProfileViewController,HomeViewController
    }
}
//----------------   PickerView  delegate Method   --------------------------------//
extension MyProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTextFiled.tag == 106 {
            return designationNameArray.count
        }else{
            return 0
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activeTextFiled.tag == 106 {
            return designationNameArray[row]
        }else{
            return nil
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextFiled.tag == 106 {
            self.txf_selected.text = self.designationNameArray[row]
        }
    }
    
    func didTapDone() {
        if activeTextFiled.tag == 106 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.activeTextFiled.resignFirstResponder()
        }
    }
    
    func didTapCancel() {
        if activeTextFiled.tag == 106 {
            self.txf_selected.text = nil
            self.txf_selected.resignFirstResponder()
        }
    }
    func alertAction(endUserMessage : String, statuseCode : Int){
        DispatchQueue.main.async {
            if statuseCode == 200 {
                //        self.appDelegate.window?.makeToast("endUserMessage" , duration:"kToastDuration", position:.center)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: endUserMessage, preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
//MARK: - UIImagePickerControllerDelegate

extension MyProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
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
            
            self.imgview.image = selectedImage
            
            print("selectedImage",selectedImage)
          //  self.img_view.image = selectedImage
           
        }else{
            
            // let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            
            self.imgview.image = selectedImage
           // self.isChangeImage = true
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        /*
//         Get the image from the info dictionary.
//         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
//         instead of `UIImagePickerControllerEditedImage`
//         */
//        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
//            print("pickedImage",pickedImage)
//            self.img_view.image = pickedImage
//            self.isChangeImage = true
//        }
//        //Dismiss the UIImagePicker after selection
//        picker.dismiss(animated: true, completion: nil)
//    }
    //    func openCamera()
    //    {
    //        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
    //        {
    //            imagePicker?.sourceType = UIImagePickerController.SourceType.camera
    //            imagePicker?.allowsEditing = true
    //            self.present(imagePicker!, animated: true, completion: nil)
    //        }
    //        else
    //        {
    //            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            self.present(alert, animated: true, completion: nil)
    //        }
    //    }
    //
    //    func openGallary()
    //    {
    //        self.imagePicker?.sourceType = UIImagePickerController.SourceType.photoLibrary
    //        self.imagePicker?.allowsEditing = true
    //        self.present(self.imagePicker!, animated: true, completion: nil)
    //    }
}
