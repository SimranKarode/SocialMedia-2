//
//  UpdateBussinessProfileViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 10/03/22.
//

import UIKit
import JGProgressHUD
import ObjectMapper
import AFNetworking


class UpdateBussinessProfileViewController: UIViewController,UITextFieldDelegate,ToolbarPickerViewDelegate {
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var txf_Name: UITextField!
    @IBOutlet weak var txf_Email: UITextField!
    @IBOutlet weak var txf_PhoneNumber: UITextField!
    @IBOutlet weak var txf_CompanyName: UITextField!
    @IBOutlet weak var txf_CompanyAddress: UITextField!
    @IBOutlet weak var txf_Webisite: UITextField!
    
    @IBOutlet weak var listshow_Btn: UIButton!
    
    @IBOutlet weak var save_Btn: UIButton!
    
    
    @IBOutlet weak var back_btn: UIButton!
    
    
    @IBOutlet weak var lbl_Navtitle: UILabel!
    
    
    @IBOutlet weak var txf_designation: UITextField!
    
    var activeTextFiled = UITextField()
    let hud = JGProgressHUD()
    
//    declaration
    var loginuserid = ""
    var loginUserName = ""
    var loginPhoneNumber = ""
    var yournameStr = ""
    var emailStr = ""
    var phoneNumberStr = ""
    var companyNameStr = ""
    var companyAddStr = ""
    var webisiteStr = ""
    var bussinesStr = ""
    
    fileprivate let pickerView = ToolbarPickerView()
    fileprivate let routeArray = ["Manager", "HR", "Network", "IT"]
    
    var designationNumberArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","12","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93"]
    var designationNameArray = ["Real Estate","Marble & CVeramic","Clothes Business","Daily & Sweets Store","Daily & Sweets Store","Electrical Services Provider","FMCG & Grocery","Hardware & Sanitaryware","Tours & Travels","Wood Buisness","Resaurant,Cafe & Catering","Furniture","Advocate","Automobile Business","Agriculture Business","Chartered Accountant","Chemical","Clinic & Hospital","Storage & Warehouse","Cosmetic Store","Education Business","Education Business","Education Business","Event Agency","Loan & Finance","Fire Safety","Flower","Electronics","Fruits & Vegetable","Goggles & Spectacles","Graphics Designing","Gym & Yoga","Home Appliances","Home Automation","Other","Import & Export","Interior Maker","Jewellery","Lighting Business","Man Power Provider","Pharmaceutical","Photographer","Politics","Printing Service Provider","Security Surveillance Service(CCTV)","Social Activities","Solar & Power Panel","Sport Academy","Stationery Store","Steel and Aluminumn Business","Tailor","Textile Industry","Gift Articles & Toys","Cycles","Consultant","Dental","Salon, Spa & Beauty Parlour","Mechanical Garage","Stationery Store","Doctor","Astrologer","Ayurvedic","Hotel","Immigration Visa Consultant","Insurance","Laundry Dry Cleaner","Marketing Agency","Musical Business","Packaging","Painting & Color Services","Petrol Pump","RO Water","Mobile Sales & Repair","Car Towing & Crane Service","IT & Software","Industrial Oils & Grease","Pump Sales Services","Nursery","Electric Bikes","Internet Service Provider","Animal Food","Civil Contractor","Dance Class Academy","Watch Manufacturing & Store","Housekeeping & Cleaning","BJP - Bharatiy Janta Party","Idian National Congress","AAP - Aam Aadmi Party","Shiv Sena Party","Samajwadi Party","Footware Store","Tyre","Stock Market Advisor","Diamond","Incense Sticks","Vehicle GPS Tracker","Helth Care"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        save_Btn.layer.borderWidth = 1.0
        save_Btn.layer.borderColor = UIColor.clear.cgColor
        save_Btn.layer.cornerRadius = 10.0
        
//        let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
//
//        imgview.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "Newlogo"))

        let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
        if imgurl != nil {
            imgview.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
        }else{
            imgview.image = UIImage(named: "latestst123")
        }

        imgview.layer.borderWidth = 1
        imgview.layer.masksToBounds = false
        imgview.layer.borderColor = UIColor.systemBlue.cgColor
        imgview.layer.cornerRadius = imgview.frame.height/2
        imgview.clipsToBounds = true
        
        
//        let imageData = UserDefaults.standard.object(forKey: "ProfilPic") as? Data

      //  image = UIImage(data: imageData)

    }
    
    func getImageFromUserDefault(key:String) -> UIImage? {
        let imageData = UserDefaults.standard.object(forKey: key) as? Data
        var image: UIImage? = nil
        if let imageData = imageData {
            imgview.image = UIImage(data: imageData)
        }
        return image
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        loginuserid = loginUserid

        txf_Name.delegate = self
        txf_Email.delegate = self
        txf_PhoneNumber.delegate = self
        txf_CompanyName.delegate = self
        txf_CompanyAddress.delegate = self
        txf_Webisite.delegate = self
        txf_designation.delegate = self

        activeTextFiled.delegate = self
        txf_PhoneNumber.isUserInteractionEnabled = true

        txf_Name.tag = 1000
        txf_Email.tag = 1001
        txf_PhoneNumber.tag = 1002
        txf_CompanyName.tag = 1003
        txf_CompanyAddress.tag = 1004
        txf_Webisite.tag = 1005
        txf_designation.tag = 1006
        

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
        
        self.getprofileAPI(loginuserid: loginuserid)

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextFiled = textField
        if activeTextFiled.tag == 1000 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 1001 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 1002 {
            textField.inputView = nil
            textField.keyboardType = .numberPad
        }else if activeTextFiled.tag == 1003 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 1004 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 1005 {
            textField.inputView = nil
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 1006 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextFiled.tag == 1000 {
            self.yournameStr = textField.text!
        }else if activeTextFiled.tag == 1001 {
            self.emailStr = textField.text!
        }else if activeTextFiled.tag == 1002 {
            self.phoneNumberStr = textField.text!
        }else if activeTextFiled.tag == 1003 {
            self.companyNameStr = textField.text!
        }else if activeTextFiled.tag == 1004 {
            self.companyAddStr = textField.text!
        }else if activeTextFiled.tag == 1005 {
            self.webisiteStr = textField.text!
        }else if activeTextFiled.tag == 1006 {
            self.bussinesStr = textField.text!
        }
    }
    

    // MARK: - KeyBoard Handiling 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
          textField.resignFirstResponder()
            textField.endEditing(true)
            return true
        }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func save_BtnActn(_ sender: UIButton) {
        
//        UserDefaults
       
        
        
        self.txf_Email.endEditing(true)
        self.txf_Name.endEditing(true)
        self.txf_designation.endEditing(true)
        self.txf_Webisite.endEditing(true)
        self.txf_PhoneNumber.endEditing(true)
        self.txf_CompanyName.endEditing(true)
        self.txf_CompanyAddress.endEditing(true)


        let nameStr = txf_Name.text
        let emailStr = txf_Email.text
        let phonenumberStr = txf_PhoneNumber.text
        let companynameStr = txf_CompanyName.text
        let companyAddressStr = txf_CompanyAddress.text
        let designationStr = txf_designation.text
        let websiteStr = txf_Webisite.text



        if nameStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Name")
        }else if emailStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter email")
        }else if phonenumberStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Valid Phone Number")
        }else if companynameStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter company name")
        }else if companyAddressStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter company address")
        }else if designationStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Valid password")
        }else if websiteStr == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter website")
        }else{
            UpdateProfile()
        }
    }
    
    // MARK Getting Profile List
    
    

    
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
                self.emailStr = respVO.email ?? ""
                self.phoneNumberStr = respVO.phone ?? ""
                self.loginUserName = respVO.name ?? ""
                self.companyNameStr = respVO.company_name ?? ""
                self.companyAddStr = respVO.adress ?? ""
                self.webisiteStr = respVO.website ?? ""
                self.bussinesStr = respVO.business_type ?? ""
                self.updateDataUI()
            }else{
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    func updateDataUI(){

        txf_Name.text = loginUserName
        txf_Email.text = emailStr
        txf_PhoneNumber.text = phoneNumberStr
        txf_CompanyName.text = companyNameStr
        txf_CompanyAddress.text = companyAddStr
        txf_designation.text = bussinesStr
        txf_Webisite.text = webisiteStr
    }
// MARK Getting Profile List Update Changes
    
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
        parameters["website"] = webisiteStr
        parameters["business_type"] = bussinesStr
        
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
                self.loginShowAlert(alertTitle: "Alert!", message: "Profile updated successfully")
               
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
}
//----------------   PickerView  delegate Method   --------------------------------//
extension UpdateBussinessProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTextFiled.tag == 1006 {
            return designationNameArray.count
        }else{
            return 0
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activeTextFiled.tag == 1006 {
            return designationNameArray[row]
        }else{
            return nil
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextFiled.tag == 1006 {
            self.txf_designation.text = self.designationNameArray[row]
        }
    }
    
    func didTapDone() {
        if activeTextFiled.tag == 1006 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.bussinesStr = self.designationNameArray[row]
            self.txf_designation.resignFirstResponder()
        }
    }
    
    func didTapCancel() {
        if activeTextFiled.tag == 1006 {
            self.txf_designation.text = nil
            self.txf_designation.resignFirstResponder()
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
