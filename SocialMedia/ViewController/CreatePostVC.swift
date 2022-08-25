//
//  CreatePostVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 15/04/22.
//

import UIKit
import StickerView
import AFNetworking
import ObjectMapper
import JGProgressHUD

protocol CreateNewPostPopUpDelegate {
    func fontSizeDelegate(forntSize : CGFloat)
    func selectedColorDelegate(backGroundColor : UIColor)
    func selectedImageDelegate(image : String)
    func selectedColourInfoDelegte(backGroundColor : String)
    func selectedFontTypeeDelegate(forntSize : String)

}

class CreatePostVC: UIViewController, CreateNewPostPopUpDelegate,UIGestureRecognizerDelegate,CreatePostPopUpDelegate {
    func selectedOverplayDelegate(backGroundColor: UIColor) {
        
    }
    
    
    
    @IBOutlet weak var img_frameProfile: JLStickerImageView!
    
    @IBOutlet weak var img_frameTranspernt: UIImageView!
    
    @IBOutlet weak var img_topImage: UIImageView!
    
    
    @IBOutlet weak var topimg_Sticker: JLStickerImageView!
    
    
    @IBOutlet weak var test_image: UIImageView!
    
    
    
    @IBOutlet weak var create_collectionview: UICollectionView!
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    
    
    @IBOutlet weak var back_view: JLStickerImageView!
    
    
    @IBOutlet weak var createpost_collectionview: UICollectionView!
    
//    @IBOutlet weak var img_view: JLStickerImageView!
//    @IBOutlet weak var selected_sticker: UIImageView!
//    @IBOutlet weak var img_support: JLStickerImageView!
    
    @IBOutlet weak var Static_login: UICollectionView!
    
    @IBOutlet weak var next_Btn: UIButton!
    
    
    @IBOutlet weak var img1: JLStickerImageView!
    
    
    @IBOutlet weak var img12: UIImageView!
    
    
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
    
    
    @IBOutlet weak var icon_view: UIView!
    
    @IBOutlet weak var icon_img1: UIImageView!
    
    @IBOutlet weak var icon_img2: UIImageView!
    
    
    @IBOutlet weak var static_lbl: UILabel!
    
    var MainArrayList = ["Image","TopImage","Sticker","Text","Colour","FontStyle"]
    
    var ImagemainArrayList = ["c_1","qc_gallery-1","emoji_icon","text","qc_bacground_color","qc_text_font"]
    
    var imagePicker : UIImagePickerController?=UIImagePickerController()
    var isChangeImage : Bool = Bool()
    
    
    var colorsArray = [UIColor.cyan,UIColor.white, UIColor.black, UIColor.yellow,UIColor.red,UIColor.blue,UIColor.purple,UIColor.gray,UIColor.green,UIColor.lightGray,UIColor.darkGray]
    var fontNamesArray = ["AppleSDGothicNeo-Thin","HelveticaNeue-Thin","AcademyEngravedLetPlain", "AlNile-Bold", "Chalkduster"]
    var contactDetailArray = ["Logo","Name","Phone","Email","Web","Designation"]

    var selectedImageType = ""
    let hud = JGProgressHUD()
    
    var graphicJsonArray:[GraphicJsonVo] = Array<GraphicJsonVo>()
    var graphicResultArray:[GPResultVo] = []
    
    var overplayImage : UIImage?
    
    var isSelectedOther = false
    var isSelectedOtherTher = false
    
    var isSelectedPhoneStr = false
    var isSelectedEmailStr = false
    var isSelectedWebStr = false
    var isSelectedDesignationtr = false
    
    let defaults = UserDefaults.standard
    var savedImageArray = [UIImage]()
    
    
    var loginName = ""
    var loginPhone = ""
    var loginEmail = ""
    var loginAdress = ""
    var loginDesignation = ""
    var loginWeb = ""
    var loginProfilPic = ""
    
    var selctedtag = ""
    
    var i=Int()
    var episodResultArray:[EpispdeResultVo] = []
    var isImageFromSelected = ""
    
    var selectedFrame = ""
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        static_lbl.text = "Social Media 8879022022"
        static_lbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        
        
        let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
        if imgurl != nil {
            profilepic.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
        }else{
            profilepic.image = UIImage(named: "latestst123")
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfCreatePostReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        //https://socialmediaallinone.com/sma_admin/uploads/video_thumb/114.jpg
        
       // selected_sticker.contentMode = .scaleAspectFill
       // back_image.image = UIImage(named: isImageFromSelected)
//        if i < episodResultArray.count{
//            i+=1
        img_frameTranspernt.sd_setImage(with:URL(string: isImageFromSelected) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
      //  }

        create_collectionview.delegate = self
        create_collectionview.dataSource =  self
        create_collectionview.register(UINib(nibName: "CollourViewCell", bundle: nil), forCellWithReuseIdentifier: "CollourViewCell")
        
        create_collectionview.delegate = self
        createpost_collectionview.dataSource =  self
                createpost_collectionview.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")
        
        Static_login.delegate = self
        Static_login.dataSource =  self
        Static_login.register(UINib(nibName: "NameViewCell", bundle: nil), forCellWithReuseIdentifier: "NameViewCell")
        
        self.socialMedia()
     //   self.yourDataLoad()
        next_Btn.layer.cornerRadius = 6
        next_Btn.layer.borderWidth = 1
        next_Btn.layer.borderColor = UIColor.systemGray.cgColor
        
//        static_lbl.text = "Social Media 0000000000"
//        static_lbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        self.view_Name.isHidden = true
        self.view_Email.isHidden = true
        self.view_Phone.isHidden = true
        self.view_Web.isHidden = true
        self.view_Designation.isHidden = true
        self.view_Image.isHidden =  true 
        
//        self.createpost_collectionview.isHidden =  true
//        self.Static_login.isHidden =  true
//        img_view.contentMode = .scaleAspectFill
        
        
        self.imagePicker?.delegate = self
       // img_view.image = UIImage(named: "frameImage")
       // selected_sticker.image =  UIImage(named: "1-15")

       // selected_sticker.sd_setImage(with:URL(string: "https://socialmediaallinone.com/sma_admin/uploads/video_thumb/114.jpg") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
        
//        img_frameTranspernt.contentMode = .scaleAspectFill
        if i < episodResultArray.count{
            i+=1
            img_frameTranspernt.sd_setImage(with:URL(string: isImageFromSelected) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
        }

        
        let swipeLeftGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeLeftImage))
        back_view.isUserInteractionEnabled = true
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        back_view.addGestureRecognizer(swipeLeftGesture)

        let swipeRightGesture=UISwipeGestureRecognizer(target: self, action: #selector(SwipeRightImage))
        swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        back_view.addGestureRecognizer(swipeRightGesture)

                
        let loginNamestr = UserDefaults.standard.object(forKey:"name") as? String ?? ""
        loginName = loginNamestr
        
        let loginPhonestr = UserDefaults.standard.object(forKey:"phone") as? String ?? ""
        loginPhone = loginPhonestr
        
        let loginEmailstr = UserDefaults.standard.object(forKey:"email") as? String ?? ""
        loginEmail = loginEmailstr
        
        let loginAdressstr = UserDefaults.standard.object(forKey:"adress") as? String ?? ""
        loginAdress = loginAdressstr
        let loginDesignationstr = UserDefaults.standard.object(forKey:"Designation") as? String ?? ""
        loginDesignation = loginDesignationstr
        let loginWebstr = UserDefaults.standard.object(forKey:"Web") as? String ?? ""
        loginWeb = loginWebstr
        let loginProfilPicstr = UserDefaults.standard.object(forKey:"image_url") as? String ?? ""
        loginProfilPic = loginProfilPicstr
        
      //  let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(recognizer:)))
//        img_view!.addGestureRecognizer(pan)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfCreatePostReceivedNotification(notification:)), name: Notification.Name("CreatePostVCNotificationIdentifier"), object: nil)


        self.yourDataLoad()
        
    }
    
    //MARK: - - - - - Method for Create Post Info receiving Data through Post Notificaiton - - - - -
    @objc func methodOfCreatePostReceivedNotification(notification: Notification) {
        print("Value of notification : ", notification.object ?? "")
        let yourColor = (notification.object! as! UIColor)
        lbl_name.textColor = yourColor
        lbl_email.textColor = yourColor
        lbl_phone.textColor = yourColor

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
           let rotate5 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
           rotate5.delegate = self
           view_Name.addGestureRecognizer(rotate5)

    //email
           let gestureRecognizer11 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
           gestureRecognizer11.delegate = self
           view_Email.addGestureRecognizer(gestureRecognizer11)

           //add pinch gesture
           let pinchGesture11 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
           pinchGesture11.delegate = self
           view_Email.addGestureRecognizer(pinchGesture11)

           //add rotate gesture.
           let rotate11 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
           rotate11.delegate = self
           view_Email.addGestureRecognizer(rotate11)

//phone

        let gestureRecognizer12 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer12.delegate = self
        view_Phone.addGestureRecognizer(gestureRecognizer12)

        //add pinch gesture
        let pinchGesture12 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture12.delegate = self
        view_Phone.addGestureRecognizer(pinchGesture12)

        //add rotate gesture.
        let rotate12 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate12.delegate = self
        view_Phone.addGestureRecognizer(rotate12)

//web

        let gestureRecognizer13 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer13.delegate = self
        view_Web.addGestureRecognizer(gestureRecognizer13)

        //add pinch gesture
        let pinchGesture13 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture13.delegate = self
        view_Web.addGestureRecognizer(pinchGesture13)

        //add rotate gesture.
        let rotate13 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate13.delegate = self
        view_Web.addGestureRecognizer(rotate13)

//Designation

        let gestureRecognizer14 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer14.delegate = self
        view_Designation.addGestureRecognizer(gestureRecognizer14)

        //add pinch gesture
        let pinchGesture14 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture14.delegate = self
        view_Designation.addGestureRecognizer(pinchGesture14)

        //add rotate gesture.
        let rotate14 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate14.delegate = self
        view_Designation.addGestureRecognizer(rotate14)


        let gestureRecognizer15 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                gestureRecognizer15.delegate = self
                view_Image.addGestureRecognizer(gestureRecognizer14)

                //add pinch gesture
                let pinchGesture15 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
                pinchGesture15.delegate = self
                view_Image.addGestureRecognizer(pinchGesture15)

                //add rotate gesture.
                let rotate15 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
                rotate15.delegate = self
                view_Image.addGestureRecognizer(rotate15)



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
        @objc func methodOfReceivedNotification(notification: Notification) {
            print("Value of notification : ", notification.object ?? "")
            back_view.textColor = (notification.object! as! UIColor)

            //background_view.backgroundColor = (notification.object! as! UIColor)
            //selected_sticker.addLabel()
//            selected_sticker.textColor = (notification.object! as! UIColor)
//
//          //  selected_sticker.textColor = UIColor.green
//            selected_sticker.textAlpha = 1
//            selected_sticker.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//            selected_sticker.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//            selected_sticker.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
//            selected_sticker.currentlyEditingLabel.labelTextView?.font = selected_sticker.currentlyEditingLabel.labelTextView?.font
//            selected_sticker.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        }

    
    @objc func SwipeLeftImage(){
        if i < episodResultArray.count{
            print("LSR befor",i)
            img_frameTranspernt.sd_setImage(with:URL(string: episodResultArray[i].image_url ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
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
                img_frameTranspernt.sd_setImage(with:URL(string: episodResultArray[i].image_url ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))

            }
        }
    }
    
    
    
    
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
          let translation = recognizer.translation(in: self.view)
          if let view = recognizer.view {
              view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
          }
          recognizer.setTranslation(CGPoint.zero, in: self.view)
      }
    func selectedColorDelegate(backGroundColor: UIColor) {
        back_view.backgroundColor = backGroundColor
//        selected_sticker.addLabel()
//        selected_sticker.textColor = backGroundColor

    }
    
    func fontSizeDelegate(forntSize: CGFloat) {
        print("Test...",forntSize)
        
        //  selected_sticker.textColor = UIColor.green
//        selected_sticker.textAlpha = 1
//        selected_sticker.currentlyEditingLabel.closeView!.image = UIImage(named: "close")
//        selected_sticker.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//        selected_sticker.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
//        selected_sticker.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: forntSize)
//        selected_sticker.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
        //next_Btn.
        //  next_Btn.titleLabel?.font =  UIFont(name: forntSize, size: 20)
        
        
    }
    func selectedFontTypeeDelegate(forntSize: String) {
            print("Test...",forntSize)
            
//            //  selected_sticker.textColor = UIColor.green
//            selected_sticker.textAlpha = 1
//            selected_sticker.currentlyEditingLabel.closeView!.image = UIImage(named: "close")
//            selected_sticker.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//            selected_sticker.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
        back_view.currentlyEditingLabel.labelTextView?.fontName = forntSize
//            selected_sticker.currentlyEditingLabel.labelTextView?.font = selected_sticker.currentlyEditingLabel.labelTextView?.font

        
        
      //  selected_sticker.currentlyEditingLabel.labelTextView?.font = UIFont(name: "BLACKR", size: 30)
      //  selected_sticker.currentlyEditingLabel.labelTextView?.fontName = forntSize
        //UIFont.systemFont(ofSize: forntSize)
//            selected_sticker.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            //next_Btn.
            //  next_Btn.titleLabel?.font =  UIFont(name: forntSize, size: 20)
//        selected_sticker.tex
            
            
        }
    
    func selectedImageDelegate(image: String) {
      //  img_frameProfile.image = UIImage(named: image)
//        img_frameProfile.addImage(selectedImage: UIImage(named: image)!)
        
        back_view.addImage(selectedImage: UIImage(named: image)!)

                                   // sub_imagview.image = selectedImage
        back_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
        back_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
        back_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
    }
    func selectedColour(backGroundColor: UIColor) {
        back_view.backgroundColor = UIColor.green
    }
    
    func select(image: String) {
        
    }
  
    func selectedColourInfoDelegte(backGroundColor: String) {
        let color1 = hexStringToUIColor(hex: backGroundColor)
        self.back_view.backgroundColor = color1
        
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
    
    
    @IBAction func next_BtnActn(_ sender: UIButton) {
        
        let image = back_view.renderContentOnView()
       
       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyBannerViewController") as! MyBannerViewController
       vc.selectedImage = self.img_frameProfile.image
       vc.selectedImage = mergeImages(imageView: img_frameProfile)
       print("imageimageimage",image!)
     //        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func download_BtnActn(_ sender: UIButton) {
        
        var selectedImage : UIImage?
        img_frameTranspernt.addSubview(img_topImage)
        // let imageData = back_image.renderContentOnView()
        selectedImage = img_frameTranspernt.image
        selectedImage = mergeImages(imageView: img_frameTranspernt)
        back_view.image = selectedImage
        guard let selectedDataImage = back_view.image else {
            print("Image not found!")
            return
        }
        print("back_view.image",back_view.image as Any)
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
        
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            
            
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //MARK: - Add image to Library
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if let error = error {
//            // we got back an error!
//            showAlertWith(title: "Save error", message: error.localizedDescription)
//        } else {
//            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
//        }
//    }
//    func showAlertWith(title: String, message: String){
//        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//    }
    
    

    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
//    func mergeImages(imageView: UIImageView) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
//        imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
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

    func loginShowAlert(alertTitle : String, message : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
            
            self.selctedtag = respVO.tag ?? ""
            self.updateLoginStatu()
            
            self.graphicJsonArray.append(respVO)
    //            let listArr = respVO.output
            
            self.graphicResultArray = respVO.output!

            self.create_collectionview.reloadData()
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
//            icon_img1.isHidden = false
//            icon_img2.isHidden = false
            static_lbl.isHidden = true
            icon_img1.isHidden = true
            icon_img2.isHidden = true

        }else{
//            static_lbl.isHidden = true
//            icon_img1.isHidden = true
//            icon_img2.isHidden = true
            static_lbl.isHidden = false
            icon_img1.isHidden = false
            icon_img2.isHidden = false

        }
    }
    
    
}





extension CreatePostVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.create_collectionview {
            return graphicResultArray.count
        } else if collectionView == self.createpost_collectionview  {
            return contactDetailArray.count
        }else{
            return MainArrayList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if create_collectionview == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollourViewCell", for:  indexPath) as! CollourViewCell
            cell.imgview.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
            
            
//                        sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
//                               mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))

            return cell
        }else if createpost_collectionview == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.lbl_name.text = contactDetailArray[indexPath.row]


            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameViewCell", for:  indexPath) as! NameViewCell
            cell.lbl_name.text = MainArrayList[indexPath.row]
            cell.imgview.image = UIImage(named: ImagemainArrayList[indexPath.row])

            return cell
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if create_collectionview == collectionView {
            // img_view.addSubview(back_view)
//                        back_view.addSubview(img_view)
//                               selected_sticker.addSubview(back_view)
            img_topImage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))
            
            
            //            sub_imagview.image = UIImage(named: graphicResultArray[indexPath.row].images ?? "")
            //                   mainimage.sd_setImage(with:URL(string: graphicResultArray[indexPath.row].images ?? "") , placeholderImage: #imageLiteral(resourceName: "SocialMedia"))
        }else if createpost_collectionview == collectionView{
            if indexPath.item == 0 {
                
//               // selected_sticker.sizeToFit()
//                    //    selected_sticker.isUserInteractionEnabled = true
//                back_view.addSubview(img_view)
//                selected_sticker.addSubview(img_support)
//                back_view.addSubview(selected_sticker)
//
//                let selecte = UIImage(named: "SocialMedia")
//                img_view.addImage(selectedImage: selecte!)
//
//                      //Modify the Label
//                      //        stickerView.textColor = UIColor.green
//                      //        stickerView.textAlpha = 1
//                img_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//                img_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//                img_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
//                img_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                if isSelectedOtherTher == false {
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
                
                
                
            }else if indexPath.item == 1{
                if isSelectedOtherTher == false {
                    self.view_Name.isHidden = false
//
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
                    lbl_web.text = loginDesignation
                    isSelectedWebStr = true
                }else{
                    lbl_web.text = ""
                    self.view_Web.isHidden = true
                    isSelectedWebStr = false
                }
            }
        }else{
            if indexPath.item == 0 {
            selectedImageType  = "Image"
                self.imageCaptuer()
                
            }else if indexPath.item == 1{
                selectedImageType  = "Galary"

                self.imageCaptuer()
                //img_topImage
                
               // img_topImage.image = UIImage(named: "123-1")
                
                //
                
//                back_view.addImage(selectedImage: UIImage(named: "123-1")!)

                              // sub_imagview.image = selectedImage
//                back_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
//                back_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
//                back_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
//                let topimg_StickerTest = UIImage(named: "123-1")
//                if let imageSticker = topimg_StickerTest {
//                    let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
//                    testImage.image = imageSticker
//                    testImage.contentMode = .scaleAspectFit
//                    let stickerView3 = StickerView.init(contentView: testImage)
//                    stickerView3.center = CGPoint.init(x: 150, y: 150)
//                    stickerView3.delegate = self
//                    stickerView3.setImage(UIImage.init(named: "Close")!, forHandler: StickerViewHandler.close)
//                    stickerView3.setImage(UIImage.init(named: "Rotate")!, forHandler: StickerViewHandler.rotate)
//                    stickerView3.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
//                    stickerView3.showEditingHandlers = false
//                    stickerView3.tag = 999
//                    self.test_image.addSubview(stickerView3)
//                    self.selectedStickerView = stickerView3
//                }else{
//                    print("Sticker not loaded")
//                }
            }else if indexPath.item == 2{
                
                
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectBGIVC") as! SelectBGIVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.backGroundImage = self
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                
                

            }else if indexPath.item == 3{
                
                back_view.addLabel()
                //Modify the Label
                back_view.textColor = UIColor.black
                back_view.textAlpha = 1
                back_view.currentlyEditingLabel.labelTextView?.fontName =  "BOYCOTT"
                back_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                back_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                back_view.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
                back_view.currentlyEditingLabel.labelTextView?.font = UIFont.systemFont(ofSize: 14.0)
                back_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
            }else if indexPath.item == 4{
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourWheelsVC") as! ColourWheelsVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.colorwheels = self
               // logoutPopUpVC.postTypeVC = "CreatePostVC"
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                logoutPopUpVC.didMove(toParent: self)
            }else if indexPath.item == 5{
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFontStyleVC") as! SelectFontStyleVC
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.selectedFontStyle = self
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
            }else{
                
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
         
        if collectionView == self.create_collectionview {
            return CGSize (width: 90, height: 90)
          
        } else if collectionView == self.createpost_collectionview  {
            return CGSize (width: 90, height: 90)
          
        }else{
            return CGSize (width: 90, height: 90)
          
        }
        

 }

}


//extension CreatePostVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return MainArrayList.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CreateViewCell", for:  indexPath) as! CreateViewCell
//
////        cell.imgview.image = UIImage.init(named: "pf_s15")
////        cell.imgview.image = UIImage(named: "pf_s15")
//
//
//        cell.lbl_name.text = MainArrayList[indexPath.row]
//        cell.imgview.image = UIImage(named: ImagemainArrayList[indexPath.row])
//
//        return cell
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
////
////
////        }
//
//    }


//
//    func loadVieDataw(selectedScreen: String){
//        if selectedScreen == "Font" {
////            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FontSizeVC") as! FontSizeVC
////            self.addChild(logoutPopUpVC)
////            logoutPopUpVC.selectedFont = self
////            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            self.view.addSubview(logoutPopUpVC.view)
////            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "FontStyle" {
////            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFontStyleVC") as! SelectFontStyleVC
////            self.addChild(logoutPopUpVC)
////            logoutPopUpVC.selectedFontStyle = self
////            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            self.view.addSubview(logoutPopUpVC.view)
////            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "BackGroundImage" {
//            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectBGIVC") as! SelectBGIVC
//            self.addChild(logoutPopUpVC)
//            logoutPopUpVC.backGroundImage = self
//            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            self.view.addSubview(logoutPopUpVC.view)
//            logoutPopUpVC.didMove(toParent: self)
//        }else if selectedScreen == "ColorWheel" {
////            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourWheelsVC") as! ColourWheelsVC
////            self.addChild(logoutPopUpVC)
////            logoutPopUpVC.colorwheels = self
////            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            self.view.addSubview(logoutPopUpVC.view)
////            logoutPopUpVC.didMove(toParent: self)
//        }else{
////            let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColourVc") as! ColourVc
////            self.addChild(logoutPopUpVC)
////            logoutPopUpVC.selectedColourInfo = self
////            logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            self.view.addSubview(logoutPopUpVC.view)
////            logoutPopUpVC.didMove(toParent: self)
//        }
//
//    }
//
//    }
//MARK: - UIImagePickerControllerDelegate

extension CreatePostVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
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
            
            if selectedImageType == "Galary" {
             //   self.img_frameProfile.image = selectedImage
                
                back_view.addImage(selectedImage: selectedImage)

                                                  // sub_imagview.image = selectedImage
                       back_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                       back_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                       back_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                
            }else{
//                selected_sticker.sizeToFit()
//                back_view.layer.borderWidth = 1
//                back_view.layer.borderColor = UIColor.white.cgColor
//                back_view.layer.cornerRadius = 10
//
                img_frameProfile.addImage(selectedImage: selectedImage)
                
               // sub_imagview.image = selectedImage
                img_frameProfile.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                img_frameProfile.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                img_frameProfile.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                //img_view.addSubview(selected_sticker)
            }
            print("selectedImage",selectedImage)
          //  self.img_view.image = selectedImage
           
        }else{
            
            // let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
            
            print("selectedImage",selectedImage)
            if selectedImageType == "Galary" {
                //                self.img_frameProfile.image = selectedImage
                back_view.layer.borderWidth = 1
                back_view.layer.borderColor = UIColor.white.cgColor
                back_view.layer.cornerRadius = 10
                back_view.addImage(selectedImage: selectedImage)
                // sub_imagview.image = selectedImage
                back_view.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                back_view.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                back_view.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                //                                back_view.addSubview(selected_sticker)
                //
            }else{
                img_frameProfile.addImage(selectedImage: selectedImage)
                
                // sub_imagview.image = selectedImage
                img_frameProfile.currentlyEditingLabel.closeView!.image = UIImage(named: "close1")
                img_frameProfile.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate")
                img_frameProfile.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
                //img_view.addSubview(selected_sticker)
                
                
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
extension CreatePostVC : StickerViewDelegate {
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
