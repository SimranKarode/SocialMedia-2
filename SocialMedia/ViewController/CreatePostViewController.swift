//
//  CreatePostViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 08/04/22.
//

import UIKit
import StickerView
import ObjectMapper
import SDWebImage
import AFNetworking
import JGProgressHUD


class CreatePostViewController: UIViewController, CreatePostPopUpDelegate,UIGestureRecognizerDelegate {
    func fontSizeDelegate(forntSize: CGFloat) {
        
    }
    
    func selectedColorDelegate(backGroundColor: UIColor) {
        
    }
    
    func selectedImageDelegate(image: String) {
        
    }
    
    func selectedColourInfoDelegte(backGroundColor: String) {
        
    }
    
    func selectedFontTypeeDelegate(forntSize: String) {
        
    }
    
    func selectedOverplayDelegate(backGroundColor: UIColor) {
        
    }
    
    
    @IBOutlet weak var backview: CardView!
    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    
    @IBOutlet weak var createpost_collectionview: UICollectionView!
    
    @IBOutlet weak var sub_imagview: JLStickerImageView!
    
   
    
    @IBOutlet weak var static_lbl: UILabel!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var back_image: JLStickerImageView!
    
    
    @IBOutlet weak var staticLogin: UICollectionView!
    
    
    @IBOutlet weak var sample_lbl: UILabel!
    
  
    
    @IBOutlet weak var main_image: UIImageView!
    
    
    @IBOutlet weak var icon_view: UIView!
    
    
    
    @IBOutlet weak var view_Name: UIView!
    
    @IBOutlet weak var view_Email: UIView!
    
    @IBOutlet weak var view_Phone: UIView!
    
    @IBOutlet weak var view_Web: UIView!
    
    @IBOutlet weak var view_Designation: UIView!
    
    @IBOutlet weak var view_Image: UIView!
    
    
    @IBOutlet weak var additional: UICollectionView!
    
    
    
    
    
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_web: UILabel!
    @IBOutlet weak var lbl_designation: UILabel!
    
    
    
    var loginName = ""
    var loginPhone = ""
    var loginEmail = ""
    var loginAdress = ""
    var loginDesignation = ""
    var loginWeb = ""
    var loginProfilPic = ""
    
    var isSelectedOther = false
    var isSelectedOtherTher = false
    
    var isSelectedPhoneStr = false
    var isSelectedEmailStr = false
    var isSelectedWebStr = false
    var isSelectedDesignationtr = false
    var isSelectedprofilepic = false
    
    var designationStr = ""
    var addressStr = ""
    
    let model = DeepLabV3()
    let context = CIContext(options: nil)
    
    
    
    var imageArray = ["gallery","create_image","c_1","qc_bacground_color","qc_gallery-1","emoji_icon","text","emoji_icon"]
    
    var contactDetailArray = ["Gallery","Crap","profile","Name","Phone","Email","Web","Desigination"]
    
    var imageArray1 = ["gallery","emoji_icon","text","emoji_icon","qc_text_font"]
    
    var contactDetailArray1 = ["Gallery","Sticker","Text","Colour","FontStyle"]
    
    var imagePicker : UIImagePickerController?=UIImagePickerController()
    var isChangeImage : Bool = Bool()
    
    var isImageFromSelected = ""
    var selectedPreviewIMage : UIImage?
    
    let defaults = UserDefaults.standard
    var savedImageArray = [UIImage]()
    
    var graphicJsonArray:[GraphicJsonVo] = Array<GraphicJsonVo>()
    var graphicResultArray:[GPResultVo] = []
    
    var images = ["f3","f4","f5","f6","pf_s15"]
    
    var i=Int()
    
    
    var otherImage : UIImage?
    
    
    var episodResultArray:[EpispdeResultVo] = []
    var selctedtag = ""
    var emailVerify: Bool?
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
    //MARK:- VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        
        static_lbl.text = "Social Media 8879022022"
        static_lbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
  
        img2.isHidden = false
        img1.isHidden = false
       
        createpost_collectionview.delegate = self
        createpost_collectionview.dataSource = self
                
        staticLogin.delegate = self
        staticLogin.dataSource = self
        
        additional.delegate = self
        additional.dataSource = self
        
        createpost_collectionview.register(UINib(nibName: "CollourViewCell", bundle: nil), forCellWithReuseIdentifier: "CollourViewCell")
        staticLogin.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")
        additional.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")

        
        
    }
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfCreatePostReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        //        self.navigationController?.navigationBar.isHidden = true
        emailVerify = false
        img1.contentMode = .scaleAspectFill
        
        
        self.view_Image.isHidden = true
        self.view_Web.isHidden = true
        self.view_Phone.isHidden = true
        self.view_Email.isHidden = true
        self.view_Designation.isHidden = true
        self.view_Name.isHidden = true
        
        
        
        self.yourDataLoad()
        
        self.imagePicker?.delegate = self
        //  back_image.image = UIImage(named: self.imageArray[Int.random(in: 0..<3)])
        
        //        backview.layer.cornerRadius = 6
        //        backview.layer.borderWidth = 1
        //        backview.layer.borderColor = UIColor.systemRed.cgColor
        //
        //        back_image.contentMode = .scaleAspectFill
        // back_image.image = UIImage(named: isImageFromSelected)
        if i < episodResultArray.count{
            i+=1
            back_image.sd_setImage(with:URL(string: isImageFromSelected) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
        }
        
        
        let swipeLeftGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeftImage))
        sub_imagview.isUserInteractionEnabled = true
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        sub_imagview.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeRightImage))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        sub_imagview.addGestureRecognizer(swipeRightGesture)
        
        
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
        
        let loginUserid = UserDefaults.standard.object(forKey:"user_id") as? String ?? ""
        getprofileAPI(loginuserid: loginUserid)
        
        let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
        if imgurl != nil {
            profilepic.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
        }else{
            profilepic.image = UIImage(named: "latestst123")
        }
        
        
    }
    //MARK: - - - - - Method for Create Post Info receiving Data through Post Notificaiton - - - - -
       @objc func methodOfCreatePostReceivedNotification(notification: Notification) {
           print("Value of notification : ", notification.object ?? "")
           let yourColor = (notification.object! as! UIColor)
           sub_imagview.textColor = yourColor
//           lbl_email.textColor = yourColor
//           lbl_phone.textColor = yourColor

      }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.socialMedia()
    }
    
    @objc func SwipeLeftImage(){
        if i < episodResultArray.count{
            print("LSR befor",i)
            back_image.sd_setImage(with:URL(string: episodResultArray[i].image_url ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
            i+=1
            print("LSR Ofter",i)
            
        }else{
            i = 0
        }
    }
    @objc func SwipeRightImage(){
        if i <= episodResultArray.count{
            print("RSR befor",i)
            if i == 0 {
                i = 0
            }else{
                i-=1
                print("RSR befor",i)
                back_image.sd_setImage(with:URL(string: episodResultArray[i].image_url ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
                
            }
        }
    }
    
    
    
    func yourDataLoad(){
        //  backPanel.addSubview(textBackView)
        //name
        let gestureRecognizer26 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer26.delegate = self
        view_Name.addGestureRecognizer(gestureRecognizer26)
        
        //add pinch gesture
        let pinchGesture26 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture26.delegate = self
        view_Name.addGestureRecognizer(pinchGesture26)
        
        //add rotate gesture.
        let rotate26 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate26.delegate = self
        view_Name.addGestureRecognizer(rotate26)
        
        //email
        let gestureRecognizer21 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer21.delegate = self
        view_Email.addGestureRecognizer(gestureRecognizer21)
        
        //add pinch gesture
        let pinchGesture21 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture21.delegate = self
        view_Email.addGestureRecognizer(pinchGesture21)
        
        //add rotate gesture.
        let rotate21 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate21.delegate = self
        view_Email.addGestureRecognizer(rotate21)
        
        //phone
        
        let gestureRecognizer22 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer22.delegate = self
        view_Phone.addGestureRecognizer(gestureRecognizer22)
        
        //add pinch gesture
        let pinchGesture22 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture22.delegate = self
        view_Phone.addGestureRecognizer(pinchGesture22)
        
        //add rotate gesture.
        let rotate22 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate22.delegate = self
        view_Phone.addGestureRecognizer(rotate22)
        
        //web
        
        let gestureRecognizer23 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer23.delegate = self
        view_Web.addGestureRecognizer(gestureRecognizer23)
        
        //add pinch gesture
        let pinchGesture23 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture23.delegate = self
        view_Web.addGestureRecognizer(pinchGesture23)
        
        //add rotate gesture.
        let rotate23 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate23.delegate = self
        view_Web.addGestureRecognizer(rotate23)
        
        //Designation
        
        let gestureRecognizer24 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer24.delegate = self
        view_Designation.addGestureRecognizer(gestureRecognizer24)
        
        //add pinch gesture
        let pinchGesture24 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture24.delegate = self
        view_Designation.addGestureRecognizer(pinchGesture24)
        
        //add rotate gesture.
        let rotate24 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate24.delegate = self
        view_Designation.addGestureRecognizer(rotate24)
        
        
        let gestureRecognizer25 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer25.delegate = self
        view_Image.addGestureRecognizer(gestureRecognizer24)
        
        //add pinch gesture
        let pinchGesture25 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture25.delegate = self
        view_Image.addGestureRecognizer(pinchGesture25)
        
        //add rotate gesture.
        let rotate25 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate25.delegate = self
        view_Image.addGestureRecognizer(rotate25)
        
        
        
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
    
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
   
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
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
            self.selctedtag = respVO.tag ?? ""
            self.updateLoginStatu()
            self.graphicJsonArray.append(respVO)
            //            let listArr = respVO.output
            
            self.graphicResultArray = respVO.output!
            
            self.createpost_collectionview.reloadData()
            //  self.hud.dismiss()
            
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
            //            self.hud.dismiss()
            //            self.loginShowAlert(alertTitle: "Alert!", message: error.localizedDescription)
        }        //  }
        
    }
    func updateLoginStatu(){
        if self.selctedtag == "0" {
            //            static_lbl.isHidden = false
            //            img1.isHidden = false
            //            img2.isHidden = false
            static_lbl.isHidden = true
            img1.isHidden = true
            img2.isHidden = true
            
        }else{
            //            static_lbl.isHidden = true
            //            img1.isHidden = true
            //            img2.isHidden = true
            static_lbl.isHidden = true
            img1.isHidden = true
            img2.isHidden = true
        }
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
    
    
    @IBAction func download_BtnActn(_ sender: UIButton) {
        var selectedImage : UIImage?
        
        //
        back_image.addSubview(sub_imagview)
        // let imageData = back_image.renderContentOnView()
        
        
        selectedImage = back_image.image
        
        selectedImage = mergeImages(imageView: back_image)
        
        
        main_image.image = selectedImage
        guard let selectedDataImage = main_image.image else {
            print("Image not found!")
            return
        }
        print("main_image.image",main_image.image as Any)
        print("selectedDataImage.image",selectedDataImage)
        //start calling vc
        let images = UserDefaults.standard.allImageArray(forKey: "SavedImageArray")
        if images != nil {
            if images!.count > 0 {
                savedImageArray = images!
                savedImageArray.append(selectedDataImage)
            }else{
                savedImageArray.append(selectedDataImage)
            }
        }else{
            savedImageArray.append(selectedDataImage)
        }
        
        //        if images!.count > 0 {
        //            savedImageArray = images!
        //            savedImageArray.append(selectedDataImage)
        //        }else{
        //            savedImageArray.append(selectedDataImage)
        //        }
        UserDefaults.standard.set(savedImageArray, forKey: "SavedImageArray")
        //sytop
        
        UIImageWriteToSavedPhotosAlbum(selectedDataImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
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
    
    
    
    
    
    
    func personaldetailes(personalInfo: String){
        
        
        sub_imagview.addLabel()
        sub_imagview.customAddLabel(selectedLabel: sample_lbl.text ?? "")
        
        //Modify the Label
        sub_imagview.textColor = UIColor.black
        sub_imagview.textAlpha = 1
        sub_imagview.currentlyEditingLabel.labelTextView?.fontName =  "BOYCOTT"
        
        sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
        sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
        sub_imagview.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        sub_imagview.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
        sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        
        //
        //        sub_imagview.customAddLabel(selectedLabel: addLabel.text!)
        //        //Modify the Label
        //        sub_imagview.textColor = UIColor.green
        //        sub_imagview.textAlpha = 1
        //        sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
        //        sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
        //        sub_imagview.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        //        sub_imagview.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
        //        sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
    }
    
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            
            
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    
    
    
    @IBAction func next_BtnActn(_ sender: UIButton) {
        
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        //        VC.selectedImage = selectedPreviewIMage
        // VC.selectedImage = self.back_image.image
        VC.selectedImage = mergeImages(imageView: back_image)
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

extension CreatePostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.createpost_collectionview {
            return graphicResultArray.count
        }else if collectionView == self.staticLogin{
            return contactDetailArray.count
        }else{
            return contactDetailArray1.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if createpost_collectionview == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CollourViewCell", for:  indexPath) as! CollourViewCell
            
            cell.imgview.tag = indexPath.item
            // cell.imgview.image = UIImage(named: graphicResultArray[indexPath.row].images )
            cell.imgview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
            return cell
        }else if staticLogin == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.lbl_name.text = contactDetailArray[indexPath.row]
            cell.imgview.image = UIImage(named: imageArray[indexPath.row])
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.imgview.image = UIImage(named: imageArray1[indexPath.row])
            cell.lbl_name.text = contactDetailArray1[indexPath.row]

            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let selectedImage = imageArray[indexPath.item]
        //        sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
        //        sub_imagview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
        
        //        let selectedImage = imageArray[indexPath.row]
        if createpost_collectionview == collectionView {
            
            sub_imagview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
            
            
        }else if staticLogin == collectionView {
            if indexPath.item == 0 {
                
                imageCaptuer()
                //                otherImage = UIImage(named: "123344566")
                //                sub_imagview.addImage(selectedImage: otherImage!)
                //
                //                // sub_imagview.image = selectedImage
                //                sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                //                sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                //                sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                
            }else if indexPath.item == 1 {
                
                //                otherImage = UIImage(named: "123344566")
                //                sub_imagview.addImage(selectedImage: otherImage!)
                //
                //                // sub_imagview.image = selectedImage
                //                sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                //                sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                //                sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                
                if otherImage != nil {
                    sub_imagview.currentlyEditingLabel.imageView?.image = removeBackground(image: otherImage!)
                }else{
                    // alert
                }
                
            }else if indexPath.item == 2 {
                
                
                if isSelectedprofilepic == false {
                    //                    self.view_Image.isHidden = false
                    //                    self.mainimage.addSubview(img_view)
                    //                    self.mainimage.addSubview(view_Name)
                    profilepic.image = UIImage(named: loginProfilPic)
                    profilepic.sd_setImage(with:URL(string: loginProfilPic) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
                    
                    isSelectedOtherTher = true
                }else{
                    self.view_Image.isHidden = true
                    
                    isSelectedOtherTher = false
                }
                //                otherImage = UIImage(named: "123344566")
                //                sub_imagview.addImage(selectedImage: otherImage!)
                //
                //                // sub_imagview.image = selectedImage
                //                sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                //                sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                //                sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                
            }else if indexPath.item == 3{
                if isSelectedOtherTher == false {
                    self.view_Name.isHidden = false
                    lbl_name.text = loginName
                    isSelectedOtherTher = true
                    
                }else{
                    self.view_Name.isHidden = true
                    lbl_name.text = ""
                    isSelectedOtherTher = false
                }
                
            }else if indexPath.item == 4{
                if isSelectedPhoneStr == false {
                    self.view_Phone.isHidden = false
                    lbl_phone.text = loginPhone
                    isSelectedPhoneStr = true
                }else{
                    self.view_Phone.isHidden = true
                    isSelectedPhoneStr = false
                }
            }else if indexPath.item == 5{
                if isSelectedEmailStr == false {
                    self.view_Email.isHidden = false
                    lbl_email.text = loginEmail
                    isSelectedEmailStr = true
                }else{
                    lbl_email.text = ""
                    self.view_Email.isHidden = true
                    isSelectedEmailStr = false
                }
            }else if indexPath.item == 6{
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
            else if indexPath.item == 7{
                if isSelectedDesignationtr == false {
                    self.view_Designation.isHidden = false
                    lbl_designation.text = loginDesignation
                    isSelectedDesignationtr = true
                }else{
                    lbl_designation.text = ""
                    self.view_Designation.isHidden = true
                    isSelectedDesignationtr = false
                }
            }
        }else{
            if indexPath.item == 0 {
                self.imageCaptuer()
            }else if indexPath.item == 1{
                
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectBGIVC") as! SelectBGIVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.backGroundImage = self
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                
                
            }else if indexPath.item == 2{
                sub_imagview.addLabel()
                //Modify the Label
                sub_imagview.textColor = UIColor.black
                sub_imagview.textAlpha = 1
                sub_imagview.currentlyEditingLabel.labelTextView?.fontName =  "BOYCOTT"
                sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                sub_imagview.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
                sub_imagview.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
                sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            }else if indexPath.item == 3{
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourWheelsVC") as! ColourWheelsVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.colorwheels = self
                // logoutPopUpVC.postTypeVC = "CreatePostVC"
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                logoutPopUpVC.didMove(toParent: self)
            }else if indexPath.item == 4 {
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFontStyleVC") as! SelectFontStyleVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.selectedFontStyle = self
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
            }else{
                
            }
        }
        //        }
    }

//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
          return CGSize (width: 130, height: 130)
  
        if collectionView == self.createpost_collectionview {
            return CGSize (width: 130, height: 130)
          
        }else  if collectionView == self.staticLogin{
            return CGSize (width: 90, height: 90)
          
        }else{
            return CGSize (width: 80, height: 80)
            
        }
    }
}





//MARK: - UIImagePickerControllerDelegate

extension CreatePostViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
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
                print("Camera Not avilable......")
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
            
            
            print("selectedImage",selectedImage)
            //self.scroll_image.image = selectedImage
            // sub_imagview.addImage()
            
            otherImage = selectedImage
            sub_imagview.addImage(selectedImage: selectedImage)
            
            // sub_imagview.image = selectedImage
            sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
            sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
            sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            
        }else{
            
            // let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            
//            print("selectedImage",selectedImage)
//             self.back_image.image = selectedImage
//            self.back_image.tag = 999
//             self.isChangeImage = true
            
            
            otherImage = selectedImage
            sub_imagview.addImage(selectedImage: selectedImage)
            
            // sub_imagview.image = selectedImage
            sub_imagview.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
            sub_imagview.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
            sub_imagview.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


extension CreatePostViewController : StickerViewDelegate {

    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    /// Other delegate methods which we not used currently but choose method according to your event and requirements.
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
    


extension UserDefaults {
    func allImageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.compactMap() { UIImage(data: $0) }
    }

    func set(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.compactMap({ $0.pngData() }), forKey: key)
    }
}

