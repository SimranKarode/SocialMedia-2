//
//  PreviewViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 10/03/22.
//

import UIKit

class PreviewViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    
    @IBOutlet weak var back_Btn: UIButton!
    
    
    @IBOutlet weak var BackView: CardView!
    
    @IBOutlet weak var imgvie: UIImageView!
    
    
    @IBOutlet weak var share_Btn: UIButton!
    @IBOutlet weak var home_Btn: UIButton!
    @IBOutlet weak var download_Btn: UIButton!
    
    @IBOutlet var mainview: UIView!
    var secureView: UIView!
    
    var selectedImage : UIImage?
    var imagePicker: UIImagePickerController!
    
    var selectedPreviewIMage = ""
    
    let defaults = UserDefaults.standard
    var savedImageArray = [UIImage]()
    
    enum ImageSource {
        case photoLibrary
        case camera
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgvie.image = selectedImage
        
        self.mainview.makeSecure()
//        imgvie.image = UIImage(named: selectedPreviewIMage)
        // Do any additional setup after loading the view.
    }
   
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  

    
    @IBAction func share_BtnActn(_ sender: UIButton) {
//        openWhatsapp()
    }
//    func openWhatsapp(){
//        let urlWhats = "whatsapp://send?phone=(mobile number with country code)"
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
//            if let whatsappURL = URL(string: urlString) {
//                if UIApplication.shared.canOpenURL(whatsappURL){
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
//                    } else {
//                        UIApplication.shared.openURL(whatsappURL)
//                    }
//                }
//                else {
//                    print("Install Whatsapp")
//                }
//            }
//        }
//    }
    
    @IBAction func home_BtnActn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func download_BtnActn(_ sender: UIButton) {
        
        guard let selectedImage = imgvie.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
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
extension UIView {
    func makeSecure(){
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}
