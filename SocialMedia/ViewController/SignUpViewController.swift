//
//  SignUpViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/03/22.
//

import UIKit
import ObjectMapper
import JGProgressHUD
import AFNetworking



class SignUpViewController: UIViewController,UITextFieldDelegate, ToolbarPickerViewDelegate {
    
    @IBOutlet weak var txf_name: UITextField!
    @IBOutlet weak var txf_mail: UITextField!
    @IBOutlet weak var txf_password: UITextField!
    
    @IBOutlet weak var txf_location: UITextField!
    
    
    @IBOutlet weak var txf_dist: UITextField!
    @IBOutlet weak var txf_block: UITextField!
    
    @IBOutlet weak var txf_designation: UITextField!
    
    @IBOutlet weak var signup_btn: UIButton!
    @IBOutlet weak var forgetpassword_btn: UIButton!
    @IBOutlet weak var login_btn: UIButton!
    
    fileprivate let pickerView = ToolbarPickerView()
    fileprivate let routeArray = ["Manager", "HR", "Network", "IT"]
    
//    var designationNumberArray = ["0","1"]
//    var designationNameArray = ["Real Estate","Marble & CVeramic"]
    
    
     var loginPhoneNumber = ""
    var designationNumberArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","12","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93"]
    var designationNameArray = ["Real Estate","Marble & CVeramic","Clothes Business","Daily & Sweets Store","Daily & Sweets Store","Electrical Services Provider","FMCG & Grocery","Hardware & Sanitaryware","Tours & Travels","Wood Buisness","Resaurant,Cafe & Catering","Furniture","Advocate","Automobile Business","Agriculture Business","Chartered Accountant","Chemical","Clinic & Hospital","Storage & Warehouse","Cosmetic Store","Education Business","Education Business","Education Business","Event Agency","Loan & Finance","Fire Safety","Flower","Electronics","Fruits & Vegetable","Goggles & Spectacles","Graphics Designing","Gym & Yoga","Home Appliances","Home Automation","Other","Import & Export","Interior Maker","Jewellery","Lighting Business","Man Power Provider","Pharmaceutical","Photographer","Politics","Printing Service Provider","Security Surveillance Service(CCTV)","Social Activities","Solar & Power Panel","Sport Academy","Stationery Store","Steel and Aluminumn Business","Tailor","Textile Industry","Gift Articles & Toys","Cycles","Consultant","Dental","Salon, Spa & Beauty Parlour","Mechanical Garage","Stationery Store","Doctor","Astrologer","Ayurvedic","Hotel","Immigration Visa Consultant","Insurance","Laundry Dry Cleaner","Marketing Agency","Musical Business","Packaging","Painting & Color Services","Petrol Pump","RO Water","Mobile Sales & Repair","Car Towing & Crane Service","IT & Software","Industrial Oils & Grease","Pump Sales Services","Nursery","Electric Bikes","Internet Service Provider","Animal Food","Civil Contractor","Dance Class Academy","Watch Manufacturing & Store","Housekeeping & Cleaning","BJP - Bharatiy Janta Party","Idian National Congress","AAP - Aam Aadmi Party","Shiv Sena Party","Samajwadi Party","Footware Store","Tyre","Stock Market Advisor","Diamond","Incense Sticks","Vehicle GPS Tracker","Helth Care"]
//
    var nameString = ""
    var emailString = ""
    var passwordString = ""
    var lcationString = ""
    var distString = ""
    var blockString = ""
    var designationstring = ""
    
    var activeTextFiled = UITextField()
    
    
    
    var stateJsonVOArr:[StateListJsonVO] = Array<StateListJsonVO>()
    var stateResultVOArr:[StateResultVO] = []

    var districtJsonVOArr:[StateListJsonVO] = Array<StateListJsonVO>()
    var districtResultVOArr:[StateResultVO] = []
    
    var cityJsonVOArr:[StateListJsonVO] = Array<StateListJsonVO>()
    var cityResultVOArr:[StateResultVO] = []
    
    let hud = JGProgressHUD()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        login_btn.layer.borderWidth = 1.0
        login_btn.layer.borderColor = UIColor.clear.cgColor
        login_btn.layer.cornerRadius = 10.0
        
        signup_btn.layer.borderWidth = 1.0
        signup_btn.layer.borderColor = UIColor.clear.cgColor
        signup_btn.layer.cornerRadius = 10.0
        
        satatListAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        activeTextFiled.delegate = self
        
        txf_name.tag = 100
        txf_mail.tag = 101
        txf_password.tag = 102
        txf_location.tag = 103
        txf_dist.tag = 104
        txf_block.tag = 105
        txf_designation.tag = 106
        
        txf_name.delegate = self
        txf_mail.delegate = self
        txf_password.delegate = self
        txf_location.delegate = self
        txf_dist.delegate = self
        txf_block.delegate = self
        txf_designation.delegate = self
        

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
            textField.keyboardType = .emailAddress
        }else if activeTextFiled.tag == 103 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }else if activeTextFiled.tag == 104 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }else if activeTextFiled.tag == 105 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }else if activeTextFiled.tag == 106 {
            textField.inputView = self.pickerView
            textField.inputAccessoryView = self.pickerView.toolbar
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if activeTextFiled.tag == 100 {
            nameString = textField.text ?? ""
        }else if activeTextFiled.tag == 101 {
            emailString = textField.text ?? ""
        }else if activeTextFiled.tag == 102 {
            passwordString = textField.text ?? ""
        }else if activeTextFiled.tag == 103 {
        }else if activeTextFiled.tag == 104 {
        }else if activeTextFiled.tag == 105 {
        }else if activeTextFiled.tag == 106 {
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
          textField.resignFirstResponder()
            textField.endEditing(true)
            return true
        }

    @IBAction func signup_BtnActn(_ sender: UIButton) {
        
//        print(nameString)
//        print(passwordString)
//        print(emailString)
//        print(lcationString)
//        print(distString)
//        print(blockString)
//        print(designationstring)
        
        let phone_number = UserDefaults.standard.object(forKey:"phone") as? String ?? ""
        loginPhoneNumber = phone_number
        
        self.txf_name.endEditing(true)
        self.txf_mail.endEditing(true)
        self.txf_password.endEditing(true)
        self.txf_location.endEditing(true)
        self.txf_dist.endEditing(true)
        self.txf_block.endEditing(true)
        self.txf_designation.endEditing(true)

       
        let nameString = txf_name.text
        let emailString = txf_mail.text
        let passwordString = txf_password.text
        let lcationString = txf_location.text
        let distString = txf_dist.text
        let blockString =  txf_block.text
        let designationstring = txf_designation.text


        if  nameString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter name")
        }else if emailString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter email")
        }else if passwordString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Password")
        }else if lcationString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Select State")
        }else if distString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Select Dist")
        }else if blockString == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Select City")
        }else if designationstring == ""{
            self.showAlert(alertTitle: "Socil Media", message: "Please Enter Designtion")
        }else{
            self.SignUp()
        }

    }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func forgetpassword_BtnActn(_ sender: UIButton) {
    }
    
    @IBAction func login_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func SignUp() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/signup"

        let parameters:NSMutableDictionary = NSMutableDictionary()

        parameters["email"] = emailString
        parameters["password"] = passwordString
        parameters["name"] = nameString
        parameters["mobile"] = loginPhoneNumber
        parameters["district"] = distString
        parameters["tehsil"] = blockString
        parameters["state"] = lcationString
        parameters["designation"] = designationstring


        //designation,tehsil,district
        print(url)

        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>


        manager.post(url, parameters: parameters, headers: ["API-KEY" : "8e90d71140a94bb"], constructingBodyWith: { (formData : AFMultipartFormData!) in

        }, progress: nil, success: { [self] (operation,LoginResponse) in
            print(LoginResponse as Any)
            let result = LoginResponse as! NSDictionary
            
            let yourName = result["email"] as? String
            let currentOTP = result["otp"] as? String
            
            let status = result["status"] as? String
            let user_id = result["user_id"] as? String
            let name = result["name"] as? String
            let email = result["email"] as? String
            let phone = result["phone"] as? String
            let image_url = result["image_url"] as? String
            let message = result["message"] as? String
            let otp = result["otp"] as? String
            
            UserDefaults.standard.set(true, forKey: "LoginStatus")
            UserDefaults.standard.set(status, forKey: "status")
            UserDefaults.standard.set(user_id, forKey: "user_id")
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(phone, forKey: "phone")
            UserDefaults.standard.set(image_url, forKey: "image_url")
            UserDefaults.standard.set(message, forKey: "message")
            UserDefaults.standard.set(otp, forKey: "otp")
            
            
            
            if status == "success" {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                vc.emailStr = email ?? ""
                vc.yournameStr = name ?? ""
                vc.phoneNumberStr = phone ?? ""
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
            }
            self.hud.dismiss()
            
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
            self.hud.dismiss()
            self.loginShowAlert(alertTitle: "Alert!", message: error.localizedDescription)
        }        //  }
//
    }
    
    func satatListAPI() {
    
        stateJsonVOArr.removeAll()
        stateResultVOArr.removeAll()
        
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/state_list"
        //
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            //            print("responseObject",responseObject)
            let respVO:StateListJsonVO = Mapper().map(JSONObject: responseObject)!
            if respVO.output != nil {
                self.stateResultVOArr = respVO.output!
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    
    func districtListAPI(selectedStateId: String) {
    
        
        districtResultVOArr.removeAll()

       // let district = "?state_id=21"
        
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/district_list?state_id=" + "" + selectedStateId
        //
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            //            print("responseObject",responseObject)
            let respVO:StateListJsonVO = Mapper().map(JSONObject: responseObject)!
            if respVO.output != nil {
                self.districtResultVOArr = respVO.output!
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    func cityListAPI(selecteddistId: String) {
    
        cityResultVOArr.removeAll()
    let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/city_list?district_id=" + "" + selecteddistId
        //
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json","API-KEY/8e90d71140a94bb"]) as Set<NSObject> as? Set<String>
        manager.get(url, parameters: "", headers: ["API-KEY" : "8e90d71140a94bb"]) { homedData in
            //print("homedData",homedData)
        } success: { [self] operation,responseObject in
            //            print("responseObject",responseObject)
            let respVO:StateListJsonVO = Mapper().map(JSONObject: responseObject)!
            if respVO.output != nil {
                self.cityResultVOArr = respVO.output!
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    
    func loginShowAlert(alertTitle : String, message : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
//----------------   PickerView  delegate Method   --------------------------------//
extension SignUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTextFiled.tag == 103 {
            return self.self.stateResultVOArr.count
        }else if activeTextFiled.tag == 104 {
            return districtResultVOArr.count
        }else if activeTextFiled.tag == 105 {
            return cityResultVOArr.count
        }else if activeTextFiled.tag == 106 {
            return designationNameArray.count
        }else{
        return 0
      }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activeTextFiled.tag == 103 {
            return self.self.stateResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 104 {
            return districtResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 105 {
            return cityResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 106 {
            return designationNameArray[row]
        }else{
            return nil
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextFiled.tag == 103 {
            self.txf_location.text = self.stateResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 104 {
            self.txf_dist.text = districtResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 105 {
            self.txf_block.text = cityResultVOArr[row].name ?? ""
        }else if activeTextFiled.tag == 106 {
            self.txf_designation.text = designationNameArray[row]
        }

    }
    
    func didTapDone() {
        if activeTextFiled.tag == 103 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            
            self.lcationString = self.stateResultVOArr[row].name ?? ""
            print("self.lcationString",self.lcationString)
            districtListAPI(selectedStateId: self.stateResultVOArr[row].id ?? "")

            self.activeTextFiled.resignFirstResponder()
        }else if activeTextFiled.tag == 104 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            if districtResultVOArr.count > 0 {
                self.distString = districtResultVOArr[row].name ?? ""
                //2nd api dist
                cityListAPI(selecteddistId: self.districtResultVOArr[row].id ?? "")
            }

            print("self.distString",self.distString)
            self.activeTextFiled.resignFirstResponder()
        }else if activeTextFiled.tag == 105 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.blockString = cityResultVOArr[row].name ?? ""
            print("self.blockString",self.blockString)
            self.activeTextFiled.resignFirstResponder()
        }else if activeTextFiled.tag == 106 {
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.pickerView.selectRow(row, inComponent: 0, animated: false)
            self.designationstring = designationNameArray[row]
            print("self.designationstring",self.designationstring)
            self.activeTextFiled.resignFirstResponder()
        }
    }
    
    func didTapCancel() {
        if activeTextFiled.tag == 103 {
            self.txf_location.text = nil
            self.txf_location.resignFirstResponder()
        }else if activeTextFiled.tag == 104 {
            self.txf_dist.text = nil
            self.txf_dist.resignFirstResponder()
        }else if activeTextFiled.tag == 105 {
            self.txf_block.text = nil
            self.txf_block.resignFirstResponder()
        }else if activeTextFiled.tag == 106 {
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
