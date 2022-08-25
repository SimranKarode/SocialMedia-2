//
//  MyBannerViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 10/03/22.
//

import UIKit
//import PlaygroundSupport

class MyBannerViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var back_Btn: UIButton!
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    
    @IBOutlet weak var delete_Btn: UIButton!
    
    @IBOutlet weak var MainBackview: CardView!
    @IBOutlet weak var imgview: UIImageView!
    
    
    @IBOutlet weak var wtsapp_Btn: UIButton!
    @IBOutlet weak var share_Btn: UIButton!
    
    @IBOutlet weak var download_btn: UIButton!
    
    
    var documentInteractionController:UIDocumentInteractionController!
    var selectedImage : UIImage?
    var selectedIndex : Int?

    var imagePicker: UIImagePickerController!
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    var deletefunctionality : Deletefunctionality?
    
    let defaults = UserDefaults.standard
    var savedImageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgview.image = selectedImage
        imgview.layer.cornerRadius = 6
        imgview.layer.borderWidth = 1
        imgview.layer.borderColor = UIColor.systemOrange.cgColor
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func delete_BtnActn(_ sender: UIButton) {
        if let delegate = deletefunctionality {
//            let images = UserDefaults.standard.allImageArray(forKey: "SavedImageArray")
//            savedImageArray = images!
                        // show the alert
//            self.showAlertWith(title: "Title", message: "Delete Selected Image")
            delegate.deleteDelegate(delete: selectedIndex!)
            self.navigationController?.popViewController(animated: true)
            

        }
    }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        openWhatsapp()
    }
    
    
    @IBAction func wtsApp_BtnActn(_ sender: UIButton) {
        Share2()
    }
   
    func sharePicture() {
        let urlWhats = "whatsapp://app"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    
                    let imgURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileName = "yourImageName.jpg"
                    let fileURL = imgURL.appendingPathComponent(fileName)
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        if let imageData = image.jpegData(compressionQuality: 0.75) {
                            let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/yourImageName.jpg")
                            do {
                                try imageData.write(to: tempFile!, options: .atomicWrite)
                                self.documentInteractionController = UIDocumentInteractionController(url: tempFile!)
                                self.documentInteractionController.uti = "net.whatsapp.image"
                                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                            } catch {
                                print(error)
                            }
                        }
                    }
                } else {
                    // Cannot open whatsapp
                }
            }
        }
    }
    func Share2(){
        let someText:String = "Social Media"
        let objectsToShare:URL = URL(string: "https://www.sterlex.in/strlex/")!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    func openWhatsapp(){
        let urlWhats = "whatsapp://send?phone=(mobile number with country code)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func share_BtnActn(_ sender: UIButton) {
//        let message = "Message goes here."
//        //Set the link to share.
//        if let link = NSURL(string: "http://yoururl.com")
//        {
//            let objectsToShare = [message,link] as [Any]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
//            self.present(activityVC, animated: true, completion: nil)
//        }
        sharePicture()
    }
    
    
    @IBAction func download_BtnActn(_ sender: UIButton) {
        guard let selectedImage = imgview.image else {
            
            print("Image not found!")
            return
        }
       
        let images = UserDefaults.standard.allImageArray(forKey: "SavedImageArray")
        if images != nil {
            if images!.count > 0 {
                savedImageArray = images!
                savedImageArray.append(selectedImage)
            }else{
                savedImageArray.append(selectedImage)
            }
        }else{
            savedImageArray.append(selectedImage)
        }
        
        UserDefaults.standard.set(savedImageArray, forKey: "SavedImageArray")
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        let selectedImageArray = imgview.image
        imgview.image = selectedImageArray
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
    
}
