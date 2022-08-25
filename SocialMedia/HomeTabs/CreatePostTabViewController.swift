//
//  CreatePostTabViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 07/04/22.
//

import UIKit
import StickerView
import AFNetworking
import ObjectMapper
import SDWebImage
import Alamofire
import CoreML



protocol CreatePostPopUpDelegate {
    func fontSizeDelegate(forntSize : CGFloat)
    func selectedColorDelegate(backGroundColor : UIColor)
    func selectedImageDelegate(image : String)
    func selectedColourInfoDelegte(backGroundColor : String)
    func selectedFontTypeeDelegate(forntSize : String)
    func selectedOverplayDelegate(backGroundColor : UIColor)

}
  
class CreatePostTabViewController: UIViewController,CreatePostPopUpDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate {
//    IRStickerViewDelegate
    func selectedOverplayDelegate(backGroundColor: UIColor) {
//        img_view.image = overplayImage?.tintImage(with: backGroundColor)
//        img_view.addImage(selectedImage: img_view.image!)
//
//        // sub_imagview.image = selectedImage
//        img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//        img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//        img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        
    }
    
    
 
    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var img_view: JLStickerImageView!
    @IBOutlet weak var back_Btn: UIButton!
    @IBOutlet weak var next_Btn: UIButton!
    @IBOutlet weak var mainimage: JLStickerImageView!
    
    
    @IBOutlet weak var frame_collectionview: UICollectionView!
    
    @IBOutlet weak var Custom_Design: UICollectionView!
    
    @IBOutlet weak var Static_login: UICollectionView!
    
    
    @IBOutlet weak var view_Name: UIView!
    
    @IBOutlet weak var view_Email: UIView!
    
    @IBOutlet weak var view_Phone: UIView!
    
    @IBOutlet weak var view_Web: UIView!
    
    @IBOutlet weak var view_Designation: UIView!
    
    
    @IBOutlet weak var view_Image: UIView!
    
    
    @IBOutlet weak var profilepic: UIImageView!
    
    
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_web: UILabel!
    @IBOutlet weak var lbl_designation: UILabel!
    
    
    
    
    var window: UIWindow?

    
    
    var overplayImage : UIImage?
    
    var isSelectedOther = false
    var isSelectedOtherTher = false
    var isSelectedPhoneStr = false
    var isSelectedEmailStr = false
    var isSelectedWebStr = false
    var isSelectedDesStr = false
    var isSelectedprofilepic = false
//    var ImagemainArrayList = ["Social Media ICON-28","gallery","overlay"]
    
    let model = DeepLabV3()
    let context = CIContext(options: nil)
    
    
    var graphicJsonArray:[GraphicJsonVo] = Array<GraphicJsonVo>()
    var graphicResultArray:[GPResultVo] = []
    
    
    //    var MainArrayList = ["Logo","Colour","Font","Gallery","Background Image","OverPlay","Add Text","Text Colour","FontSize"]
//    var ImagemainArrayList = ["add","color","fontsize","gallery","gallery","overlay","Social Media ICON-28","textcolor","fontsize"]
    
    var imagePicker : UIImagePickerController?=UIImagePickerController()
    var isChangeImage : Bool = Bool()
    
    
    var colorsArray = [UIColor.cyan,UIColor.white, UIColor.black, UIColor.yellow,UIColor.red,UIColor.blue,UIColor.purple,UIColor.gray,UIColor.green,UIColor.lightGray,UIColor.darkGray]
    var fontNamesArray = ["AppleSDGothicNeo-Thin","HelveticaNeue-Thin","AcademyEngravedLetPlain", "AlNile-Bold", "Chalkduster"]
    
    var selectedImageType = ""
    
    var loginName = ""
    var loginPhone = ""
    var loginEmail = ""
    var loginAdress = ""
    var loginDesignation = ""
    var loginWeb = ""
    var loginProfilPic = ""
    
    var otherImage : UIImage?
       
    
    private var _selectedStickerView:StickerView?
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }
    
//    var customDesignArray = ["Text","Gallery","backimage","TopImage","Sticker","colour"]
    var MainArrayList3 = ["Text","Gallery","Colour"]
    var ImagemainArrayList3 = ["text","qc_gallery-1","color"]
    
    var MainArrayList = ["Text","Gallery","Overplay","Colour","Crap","FontStyle"]
    var ImagemainArrayList = ["text","qc_gallery-1","overlay","color","overlay","qc_text_font"]
    
    var contactDetailArray = ["Profile","Name","Phone","Email","Web","Designation"]
    var ImagemainArrayList2 = ["ic_profile","username","ic_callus","f2_email","f2_web","ic_category"]
    
    var designationStr = ""
    var addressStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        mainimage.contentMode = .scaleAspectFill
//        img_view.backgroundColor = .red
//        createpost_tableview.delegate = self
//        createpost_tableview.dataSource = self
        
        
        

        self.socialMedia()
        
        self.yourDataLoad()
        //        home_tableview.register( UINib(nibName:  "BannerTableViewCell", bundle: nil), forCellReuseIdentifier:  "BannerTableViewCell")
        
//        createpost_tableview.register( UINib(nibName:  "CategoryCreatePostTableViewCell", bundle: nil), forCellReuseIdentifier:  "CategoryCreatePostTableViewCell")
        
        
        frame_collectionview.delegate = self
        frame_collectionview.dataSource = self
        
        Custom_Design.delegate = self
        Custom_Design.dataSource = self
        
        Static_login.delegate = self
        Static_login.dataSource = self
        
        frame_collectionview.register(UINib(nibName: "CollourViewCell", bundle: nil), forCellWithReuseIdentifier: "CollourViewCell")
        
        Custom_Design.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")
        
        Static_login.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")
        
        
        let loginNamestr = UserDefaults.standard.object(forKey:"name") as? String ?? ""
        loginName = loginNamestr
        
        let loginPhonestr = UserDefaults.standard.object(forKey:"phone") as? String ?? ""
        loginPhone = loginPhonestr
        
        let loginEmailstr = UserDefaults.standard.object(forKey:"email") as? String ?? ""
        loginEmail = loginEmailstr
        
        let loginAdressstr = UserDefaults.standard.object(forKey:"adress") as? String ?? ""
        loginAdress = loginAdressstr
        
        
        let loginProfilPicstr = UserDefaults.standard.object(forKey:"ProfilPic") as? String ?? ""
        loginProfilPic = loginProfilPicstr
        

      //  next_Btn.set
        next_Btn.titleLabel?.font =  UIFont(name: "BOYCOTT.ttf", size: 30)

    }


    
    func yourDataLoad(){
         //  backPanel.addSubview(textBackView)
     //name
           let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
           gestureRecognizer.delegate = self
           view_Name.addGestureRecognizer(gestureRecognizer)
           //add pinch gesture
           let pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
           pinchGesture.delegate = self
          view_Name.addGestureRecognizer(pinchGesture)
           //add rotate gesture.
           let rotate = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
           rotate.delegate = self
           view_Name.addGestureRecognizer(rotate)
    //email
           let gestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
           gestureRecognizer1.delegate = self
           view_Email.addGestureRecognizer(gestureRecognizer1)
           //add pinch gesture
           let pinchGesture1 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
           pinchGesture1.delegate = self
           view_Email.addGestureRecognizer(pinchGesture1)
           //add rotate gesture.
           let rotate1 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
           rotate1.delegate = self
           view_Email.addGestureRecognizer(rotate1)
//phone
        let gestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer2.delegate = self
        view_Phone.addGestureRecognizer(gestureRecognizer2)
        //add pinch gesture
        let pinchGesture2 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture2.delegate = self
        view_Phone.addGestureRecognizer(pinchGesture2)
        //add rotate gesture.
        let rotate2 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate2.delegate = self
        view_Phone.addGestureRecognizer(rotate2)
//web
        let gestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer3.delegate = self
        view_Web.addGestureRecognizer(gestureRecognizer3)
        //add pinch gesture
        let pinchGesture3 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture3.delegate = self
        view_Web.addGestureRecognizer(pinchGesture3)
        //add rotate gesture.
        let rotate3 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate3.delegate = self
        view_Web.addGestureRecognizer(rotate3)
//Designation
        let gestureRecognizer4 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer4.delegate = self
        view_Designation.addGestureRecognizer(gestureRecognizer4)
        //add pinch gesture
        let pinchGesture4 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture4.delegate = self
        view_Designation.addGestureRecognizer(pinchGesture4)
        //add rotate gesture.
        let rotate4 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate4.delegate = self
        view_Designation.addGestureRecognizer(rotate4)
        
        let gestureRecognizer5 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer5.delegate = self
        view_Image.addGestureRecognizer(gestureRecognizer5)
        //add pinch gesture
        let pinchGesture5 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture5.delegate = self
        view_Image.addGestureRecognizer(pinchGesture5)
        //add rotate gesture.
        let rotate5 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate5.delegate = self
        view_Image.addGestureRecognizer(rotate5)
        
        
        
        
       }
       
       @objc func handlePan(_ pan: UIPanGestureRecognizer) {
           if pan.state == .began || pan.state == .changed {
               guard let v = pan.view else { return }
               let translation = pan.translation(in: self.view)
               v.center = CGPoint(x: v.center.x + translation.x, y: v.center.y + translation.y)
               pan.setTranslation(CGPoint.zero, in: self.view)
           }
       }

       
       @objc func handlePinch(_ pinch: UIPinchGestureRecognizer) {
           guard let v = pinch.view else { return }
           v.transform = v.transform.scaledBy(x: pinch.scale, y: pinch.scale)
           pinch.scale = 1
       }
       
       @objc func handleRotate(_ sender: UIRotationGestureRecognizer) {
   //        guard let v = rotate.view else { return }
   //        v.transform = v.transform.rotated(by: rotate.rotation)
   //        rotate.rotation = 0
           
           var lastRotation: CGFloat = 0
           var BeginRotation = CGFloat()
           if sender.state == .began {
               print("rotation begin")
               sender.rotation = lastRotation
               BeginRotation = sender.rotation
           } else if sender.state == .changed {
               print("rotation changing")
               let newRotation = sender.rotation + BeginRotation
               sender.view?.transform = CGAffineTransform(rotationAngle: newRotation)
           } else if sender.state == .ended {
               print("rotation end")
               lastRotation = sender.rotation
           }
           
       }
       
       func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
           return true
    }
    //MARK: - - - - - Method for receiving Data through Post Notificaiton - - - - -
        @objc func postMethodOfReceivedNotification(notification: Notification) {
            print("Value of notification : ", notification.object ?? "")
//            background_view.backgroundColor = (notification.object! as! UIColor)
//            selected_sticker.addLabel()
            img_view.textColor = (notification.object! as! UIColor)

           // img_view.textColor = UIColor.green
//            img_view.lastTouchedView = self
//            img_view.currentlyEditingLabel.isShowingEditingHandles = true
//            img_view.textAlpha = 1
//            img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//            img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//            img_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
//            img_view.currentlyEditingLabel.labelTextView?.font = img_view.currentlyEditingLabel.labelTextView?.font
//            img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.postMethodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        self.imagePicker?.delegate = self
        self.view_Image.isHidden =  true 
        self.view_Name.isHidden = true
        self.view_Email.isHidden = true
        self.view_Phone.isHidden = true
        self.view_Web.isHidden = true
        self.view_Designation.isHidden = true
        
        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        getprofileAPI(loginuserid: loginUserid)
        
  
    }
//   *// Background image remove functionality :--//*
    
    private func removeBackground(image:UIImage) -> UIImage?{
        let resizedImage = image.resized(to: CGSize(width: 513, height: 513))
        if let pixelBuffer = resizedImage.pixelBuffer(width: Int(resizedImage.size.width), height: Int(resizedImage.size.height)){
            if let outputImage = (try? model.prediction(image: pixelBuffer))?.semanticPredictions.image(min: 0, max: 1, axes: (0,0,1)), let outputCIImage = CIImage(image:outputImage){
                if let maskImage = removeWhitePixels(image:outputCIImage), let resizedCIImage = CIImage(image: resizedImage), let compositedImage = composite(image: resizedCIImage, mask: maskImage){
                    return UIImage(ciImage: compositedImage).resized(to: CGSize(width: image.size.width, height: image.size.height))
                }
            }
        }
        return nil
    }
    
    private func removeWhitePixels(image:CIImage) -> CIImage?{
        let chromaCIFilter = chromaKeyFilter()
        chromaCIFilter?.setValue(image, forKey: kCIInputImageKey)
        return chromaCIFilter?.outputImage
    }
    
    private func composite(image:CIImage,mask:CIImage) -> CIImage?{
        return CIFilter(name:"CISourceOutCompositing",parameters:
                            [kCIInputImageKey: image,kCIInputBackgroundImageKey: mask])?.outputImage
    }
    
    // modified from https://developer.apple.com/documentation/coreimage/applying_a_chroma_key_effect
    private func chromaKeyFilter() -> CIFilter? {
        let size = 64
        var cubeRGB = [Float]()
        
        for z in 0 ..< size {
            let blue = CGFloat(z) / CGFloat(size-1)
            for y in 0 ..< size {
                let green = CGFloat(y) / CGFloat(size-1)
                for x in 0 ..< size {
                    let red = CGFloat(x) / CGFloat(size-1)
                    let brightness = getBrightness(red: red, green: green, blue: blue)
                    let alpha: CGFloat = brightness == 1 ? 0 : 1
                    cubeRGB.append(Float(red * alpha))
                    cubeRGB.append(Float(green * alpha))
                    cubeRGB.append(Float(blue * alpha))
                    cubeRGB.append(Float(alpha))
                }
            }
        }
        
        let data = Data(buffer: UnsafeBufferPointer(start: &cubeRGB, count: cubeRGB.count))
        
        let colorCubeFilter = CIFilter(name: "CIColorCube", parameters: ["inputCubeDimension": size, "inputCubeData": data])
        return colorCubeFilter
    }
    
    // modified from https://developer.apple.com/documentation/coreimage/applying_a_chroma_key_effect
    private func getBrightness(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        var brightness: CGFloat = 0
        color.getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        return brightness
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
                self.addressStr = respVO.website ?? ""
                self.designationStr = respVO.business_type ?? ""
                self.updateDataUI()
            }else{
            }
        } failure: {operation, error in
            print("error",error)
        }
    }
    func updateDataUI() {
        UserDefaults.standard.set(designationStr, forKey: "Designation")
        UserDefaults.standard.set(addressStr, forKey: "Web")
        let loginDesignationstr =  UserDefaults.standard.object(forKey:"Designation") as? String ?? ""
        loginDesignation = loginDesignationstr
        
        let loginWebstr = UserDefaults.standard.object(forKey:"Web") as? String ?? ""
        loginWeb = loginWebstr
        

    }
    
    
    
    func selectedColorDelegate(backGroundColor: UIColor) {
        background_view.backgroundColor = backGroundColor
//        selected_sticker.addLabel()
//        selected_sticker.textColor = backGroundColor

    }
    
    func fontSizeDelegate(forntSize: CGFloat) {
        print("Test...",forntSize)
        
        //  selected_sticker.textColor = UIColor.green
        img_view.textAlpha = 1
        img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close")
        img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
        img_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        img_view.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: forntSize)
        img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        //next_Btn.
        //  next_Btn.titleLabel?.font =  UIFont(name: forntSize, size: 20)
        
        
    }
    func selectedFontTypeeDelegate(forntSize: String) {
            print("Test...",forntSize)
            
            //  selected_sticker.textColor = UIColor.green
//        img_view.textAlpha = 1
//        img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close")
//        img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//        img_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        img_view.currentlyEditingLabel.labelTextView?.fontName = forntSize
//        img_view.currentlyEditingLabel.labelTextView?.font = img_view.currentlyEditingLabel.labelTextView?.font

            
            
        }
    
    func selectedImageDelegate(image: String) {
        img_view.image = UIImage(named: image)
      //  img_view.addImage(selectedImage: UIImage(named: image)!)
    }
    func selectedColour(backGroundColor: UIColor) {
        background_view.backgroundColor = UIColor.green
    }
    
    func select(image: String) {

    }
  
    func selectedColourInfoDelegte(backGroundColor: String) {
        let color1 = hexStringToUIColor(hex: backGroundColor)
        self.background_view.backgroundColor = color1

    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        
        

        
//        self.navigationController?.popToRootViewController(animated: true)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
                tabBarController.selectedIndex = 0
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                if let navViewController = tabBarController.selectedViewController as? UINavigationController{
                    navViewController.setViewControllers([viewController], animated: true)
                 //   let appDelegateP = UIApplication.shared.delegate as! AppDelegate
                    let appDelegateP = UIApplication.shared
                    appDelegateP.windows.first?.rootViewController = tabBarController
                }

        
    }
    
    @IBAction func next_BtnActn(_ sender: UIButton) {
        //render text on Image and save the Image
        _ = img_view.renderContentOnView()
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
//        vc.selectedImage = self.img_view.image
//        vc.selectedImage = mergeImages(imageView: img_view)
//        print("imageimageimage",image!)
//      //        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
//        VC.selectedImage = selectedPreviewIMage
        VC.selectedImage = self.img_view.image
        VC.selectedImage = mergeImages(imageView: img_view)
        self.navigationController?.pushViewController(VC, animated: true)

    }
    
    func mergeImages(imageView: UIImageView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
        imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
   
 
    

    //MARK:- CUSTOM METHODS
    func share(shareText:String?,shareImage:UIImage?){
        
        var objectsToShare = [AnyObject]()
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj as AnyObject)
        }
        
        if let shareImageObj = shareImage{
            objectsToShare.append(shareImageObj)
        }
        
        if shareText != nil || shareImage != nil{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
    }
    
    //MARK: - Api Integration
    
    func socialMedia() {
        let loginUserId = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""

    //        hud.textLabel.text = "Loading"
    //        hud.show(in: self.view)
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/user_graphics"

        let parameters:NSMutableDictionary = NSMutableDictionary()
        parameters["user_id"] = loginUserId
        
        //
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        
        manager.post(url, parameters: parameters, headers: ["API-KEY" : "8e90d71140a94bb"], constructingBodyWith: { (formData : AFMultipartFormData!) in
            
        }, progress: nil, success: { [self] (operation,result) in

            let respVO:GraphicJsonVo = Mapper().map(JSONObject: result)!
            
            self.graphicJsonArray.append(respVO)
    //            let listArr = respVO.output
            
            self.graphicResultArray = respVO.output!

            self.frame_collectionview.reloadData()
          //  self.hud.dismiss()
            
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
    //            self.hud.dismiss()
    //            self.loginShowAlert(alertTitle: "Alert!", message: error.localizedDescription)
        }        //  }
        
    }
    
    
    
}

extension CreatePostTabViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        
        if collectionView == self.frame_collectionview {
            return graphicResultArray.count
        } else if collectionView == self.Custom_Design  {
            return MainArrayList.count
        }else{
            return contactDetailArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if frame_collectionview == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollourViewCell", for:  indexPath) as! CollourViewCell
            cell.imgview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
//                        sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
//                               mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "1024x1024"))

            return cell
        }else if Custom_Design == collectionView{
            let cell = Custom_Design.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.lbl_name.text = MainArrayList[indexPath.row]
            cell.imgview.image = UIImage(named: ImagemainArrayList[indexPath.row])

            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.lbl_name.text = contactDetailArray[indexPath.row]
            cell.imgview.image = UIImage(named: ImagemainArrayList2[indexPath.row])
            return cell
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if frame_collectionview == collectionView {
            
            mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
            
            
            //            sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
            //                   mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "1024x1024"))
        }else if Custom_Design == collectionView{
            if indexPath.item == 0 {
                img_view.addLabel()
                //Modify the Label
                img_view.textColor = UIColor.black
                img_view.textAlpha = 1
                img_view.currentlyEditingLabel.labelTextView?.fontName =  "BOYCOTT"

                img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                img_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
                img_view.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
                img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            }else if indexPath.item == 1{
                self.imageCaptuer()
            }else if indexPath.item == 2{
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourVc") as! ColourVc
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.selectedColourInfo = self
                logoutPopUpVC.overplayStr = "Overplay"
                logoutPopUpVC.selectedImage = overplayImage
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                logoutPopUpVC.didMove(toParent: self)
                
                 
                
            }else if indexPath.item == 3{
                
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourWheelsVC") as! ColourWheelsVC
                self.addChild(logoutPopUpVC)
                   logoutPopUpVC.colorwheels = self
                        
             logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                  self.view.addSubview(logoutPopUpVC.view)
                     logoutPopUpVC.didMove(toParent: self)
                        
                      
  
                
            }else  if indexPath.item == 4 {
//                self.img_view.image = selectedImage
                
                if otherImage != nil {
                    img_view.currentlyEditingLabel.imageView?.image = removeBackground(image: otherImage!)
                    //                    sub_imagview.currentlyEditingLabel.imageView?.image = removeBackground(image: otherImage!)

                }else{
                    
                }
                }else if indexPath.item == 5{
                    let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFontStyleVC") as! SelectFontStyleVC
                    self.addChild(logoutPopUpVC)
                    logoutPopUpVC.selectedFontStyle = self
                    logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    self.view.addSubview(logoutPopUpVC.view)
                }else{
                
                }
        }else{
            if indexPath.item == 0 {
                if isSelectedprofilepic == false {
                    //                    self.view_Image.isHidden = false
                    //                    self.mainimage.addSubview(img_view)
                    //                    self.mainimage.addSubview(view_Name)
                    //                    profilepic.image = UIImage(named: loginProfilPic)
                    //                    view_Image.isHidden = false
                    //                    profilepic.sd_setImage(with:URL(string: loginProfilPic) , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
                    
                    let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
                    if imgurl != nil {
                        self.view_Image.isHidden = false

                        profilepic.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
                    }else{
                        profilepic.image = UIImage(named: "SocialMedia")
                        self.view_Image.isHidden = true
                    }
                    
                    isSelectedprofilepic = true
                }else{
                    self.view_Image.isHidden = true
                    isSelectedprofilepic = false
                }
            }else if indexPath.item == 1{
                if isSelectedOtherTher == false {
                    self.view_Name.isHidden = false
//                    self.mainimage.addSubview(img_view)
//                    self.mainimage.addSubview(view_Name)
                    lbl_name.text = loginName
                    isSelectedOtherTher = true
                }else{
                    self.view_Name.isHidden = true
                    lbl_name.text = ""
                    isSelectedOtherTher = false
                }
                
            }else if indexPath.item == 2{
                if isSelectedPhoneStr == false {
                    self.view_Phone.isHidden = false
                    lbl_phone.text = loginPhone
                    isSelectedPhoneStr = true
                }else{
                    self.view_Phone.isHidden = true
                    isSelectedPhoneStr = false
                }
            }else if indexPath.item == 3{
                if isSelectedEmailStr == false {
                    self.view_Email.isHidden = false
                    lbl_email.text = loginEmail
                    isSelectedEmailStr = true
                }else{
                    lbl_email.text = ""
                    self.view_Email.isHidden = true
                    isSelectedEmailStr = false
                }
            }else if indexPath.item == 4{
                if isSelectedWebStr == false {
                    self.view_Web.isHidden = false
                    lbl_web.text = loginWeb
                    isSelectedWebStr = true
                }else{
                    lbl_web.text = ""
                    self.view_Web.isHidden = true
                    isSelectedWebStr = false
                }
            }
            else if indexPath.item == 5{
                if isSelectedDesStr == false {
                    self.view_Designation.isHidden = false
                    lbl_designation.text = loginDesignation
                    isSelectedDesStr = true
                }else{
                    lbl_designation.text = ""
                    self.view_Designation.isHidden = true
                    isSelectedDesStr = false
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
         
        if collectionView == self.frame_collectionview {
            return CGSize (width: 100, height: 100)
          
        } else if collectionView == self.Custom_Design  {
            return CGSize (width: 90, height: 90)
          
        }else{
            return CGSize (width: 75, height: 75)
          
        }
        

 }

}

//extension CreatePostTabViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return self.MainArrayList.count
//
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCreateCollectionViewCell", for:  indexPath) as! CategoryCreateCollectionViewCell
//
//        cell.lbl_name.text = MainArrayList[indexPath.row]
//        cell.imgview.image = UIImage(named:ImagemainArrayList[indexPath.row])
//        cell.backview.layer.cornerRadius = 6
//        cell.backview.layer.borderWidth = 1
//        cell.backview.layer.borderColor = UIColor.systemOrange.cgColor
//        return cell
//
//    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//        if indexPath.item == 0 {
//            selected_sticker.addLabel()
//            selected_sticker.textColor = UIColor.green
//            selected_sticker.textAlpha = 1
//            selected_sticker.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//            selected_sticker.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//            selected_sticker.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
//            selected_sticker.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
//            selected_sticker.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
//            //Add the label
//        }else if indexPath.item == 1{
//            selectedImageType = "Galary"
//            self.imageCaptuer()
//        }else {
//            loadVieDataw(selectedScreen: "OverPlay")
//
//        }
//
//
//
//
////        if indexPath.item == 0 {
////            selectedImageType = "Logo"
////            self.imageCaptuer()
////            //Add the label
////        }else if indexPath.item == 1{
////            loadVieDataw(selectedScreen: "Color")
////        }else if indexPath.item == 2{
////            loadVieDataw(selectedScreen: "FontStyle")
////        }else if indexPath.item == 3{
////            selectedImageType = "Galary"
////            self.imageCaptuer()
////        }else if indexPath.item == 4{
////            loadVieDataw(selectedScreen: "BackGroundImage")
////        }else if indexPath.item == 5{
////            loadVieDataw(selectedScreen: "OverPlay")
////        }else if indexPath.item == 6{
////            //Modify the Label
////            selected_sticker.addLabel()
////            selected_sticker.textColor = UIColor.green
////            selected_sticker.textAlpha = 1
////            selected_sticker.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
////            selected_sticker.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
////            selected_sticker.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
////            selected_sticker.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
////            selected_sticker.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
////        }else if indexPath.item == 7{
////            loadVieDataw(selectedScreen: "ColorWheel")
////        }else if indexPath.item == 8{
////            loadVieDataw(selectedScreen: "Font")
////        }
//    }
//
//    func loadVieDataw(selectedScreen: String){
//        if selectedScreen == "Font" {
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FontSizeVC") as! FontSizeVC
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.selectedFont = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "FontStyle" {
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFontStyleVC") as! SelectFontStyleVC
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.selectedFontStyle = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "BackGroundImage" {
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectBGIVC") as! SelectBGIVC
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.backGroundImage = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "ColorWheel" {
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourWheelsVC") as! ColourWheelsVC
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.colorwheels = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }else{
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourVc") as! ColourVc
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.selectedColourInfo = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }
//
//    }
//}



//MARK: - UIImagePickerControllerDelegate

extension CreatePostTabViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imageCaptuer(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a sourcetype", preferredStyle: .alert)
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
    func BackgroundImage(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Social Media", message: "Select BackgroundImage", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Select Image", style: .default, handler: { (action:UIAlertAction) in
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
            
            otherImage = selectedImage
            if selectedImageType == "Galary" {
                self.img_view.image = selectedImage
                img_view.addImage(selectedImage: selectedImage)
                
               // sub_imagview.image = selectedImage
               
//                img_view.addSubview(img_view)
            }else{
                overplayImage = selectedImage
                img_view.layer.borderWidth = 1
                img_view.layer.borderColor = UIColor.black.cgColor
                img_view.layer.cornerRadius = 10
                img_view.addImage(selectedImage: selectedImage)
                
               // sub_imagview.image = selectedImage
                img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
//                img_view.addSubview(img_view)
            }
            print("selectedImage",selectedImage)
//            self.img_view.image = selectedImage
           
        }else{
            
            // let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            
            print("selectedImage",selectedImage)
            if selectedImageType == "Galary" {
                self.img_view.image = selectedImage
            }else{
                img_view.layer.borderWidth = 1
                img_view.layer.borderColor = UIColor.white.cgColor
                img_view.layer.cornerRadius = 10
                img_view.addImage(selectedImage: selectedImage)
                // sub_imagview.image = selectedImage
                img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                img_view.addSubview(img_view)
            }           // self.isChangeImage = true
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    

   
}

//extension CreatePostTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return graphicResultArray.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CollourViewCell", for:  indexPath) as! CollourViewCell
//
//        cell.imgview.tag = indexPath.item
//        // cell.imgview.image = UIImage(named: graphicResultArray[indexPath.row].images )
//        cell.imgview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "1024x1024"))
//
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //let selectedImage = imageArray[indexPath.item]
////        sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
//        mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "1024x1024"))
//
////        let selectedImage = imageArray[indexPath.row]
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//          return CGSize (width: 130, height: 130)
//
////        let cellsPerRow = 2
////        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
////        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
////        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
////        return CGSize(width: itemWidth, height: 150)
//    }
//}


//MARK: - Sticker-Delegate-Methods

extension CreatePostTabViewController : StickerViewDelegate {
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
}



//extension UIColor {
//   convenience init(red: Int, green: Int, blue: Int) {
//       assert(red >= 0 && red <= 255, "Invalid red component")
//       assert(green >= 0 && green <= 255, "Invalid green component")
//       assert(blue >= 0 && blue <= 255, "Invalid blue component")
//
//       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//   }
//
//   convenience init(rgb: Int) {
//       self.init(
//           red: (rgb >> 16) & 0xFF,
//           green: (rgb >> 8) & 0xFF,
//           blue: rgb & 0xFF
//       )
//   }
//}
public extension UIImage {
    
    /// Tint, Colorize image with given tint color
    /// This is similar to Photoshop's "Color" layer blend mode
    /// This is perfect for non-greyscale source images, and images that
    /// have both highlights and shadows that should be preserved<br><br>
    /// white will stay white and black will stay black as the lightness of
    /// the image is preserved
    ///
    /// - Parameter TintColor: Tint color
    /// - Returns:  Tinted image
    func tintImage(with fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(context.makeImage()!, in: rect)
        }
    }
    
    /// Modified Image Context, apply modification on image
    ///
    /// - Parameter draw: (CGContext, CGRect) -> ())
    /// - Returns:        UIImage
    fileprivate func modifiedImage(_ draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
