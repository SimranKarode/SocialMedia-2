//
//  OtherThenViewController.swift
//  Example
//
//  Created by PraveenDole on 16/05/22.
//  Copyright © 2022 luiyezheng. All rights reserved.
//

import UIKit
import StickerView

class OtherThenViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var otherTF: UITextField!
    
    
    @IBOutlet weak var backView: JLStickerImageView!
    
    @IBOutlet weak var object2: JLStickerImageView!
    @IBOutlet weak var backPanel: UIImageView!
    @IBOutlet weak var object1: JLStickerImageView!
    
    @IBOutlet weak var otherBackView: JLStickerImageView!
    //  @IBOutlet weak var yourSaveImg: UIImageView!
   // @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var hidenBack: UIView!
    
    
    @IBOutlet weak var textBackView: UIView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_email: UILabel!
    
    @IBOutlet weak var yourImage: UIImageView!
    
    
    @IBOutlet weak var viewEmail: UIView!
    var customLabel = [UIView]()
    let testView: UILabel = {
        let v = UILabel()
       // v.text = "TEST"
        v.textAlignment = .center
        v.textColor = .yellow
        
        v.layer.cornerRadius = 4.0
        v.layer.borderWidth = 4.0
        v.layer.borderColor = UIColor.red.cgColor
        v.layer.masksToBounds = true
        
        //Enable multiple touch and user interaction
        v.isUserInteractionEnabled = true
        //v.isMultipleTouchEnabled = true
        
        return v
    }()
    
    
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
        
        
        
        var yourValue = 30
        
        

        var i = 1, n = 50
        
        // while loop from i = 1 to 5
        while (i <= n) {
            print("Befor",i)
            i = i + 7
        }
        print("Ofter",i)

        
//        self.textBackView.isHidden = true
     //   self.viewEmail.isHidden = true

//        tf_name.backgroundColor = .blue
//        tf_name.text = "Other"
        //view.addSubview(testView)
       // tf_name.frame = CGRect(x: 0, y: 0, width: 240, height: 50)
       // testView.center = backPanel.center

        
      //  backView.addSubview(textBackView)
        //add pan gesture
     // yourDataLoad()
    }
    
    func yourDataLoad(){
      //  backPanel.addSubview(textBackView)

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer.delegate = self
        textBackView.addGestureRecognizer(gestureRecognizer)
        
        //add pinch gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture.delegate = self
        textBackView.addGestureRecognizer(pinchGesture)
        
        //add rotate gesture.
        let rotate = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate.delegate = self
        textBackView.addGestureRecognizer(rotate)
        
        let gestureRecognizer1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gestureRecognizer1.delegate = self
        viewEmail.addGestureRecognizer(gestureRecognizer1)

        //add pinch gesture
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action:#selector(handlePinch(_:)))
        pinchGesture1.delegate = self
        viewEmail.addGestureRecognizer(pinchGesture1)

        //add rotate gesture.
        let rotate1 = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(_:)))
        rotate1.delegate = self
        viewEmail.addGestureRecognizer(rotate1)

    }
    
    @objc func handlePan(_ pan: UIPanGestureRecognizer) {
        if pan.state == .began || pan.state == .changed {
            guard let v = pan.view else { return }
            let translation = pan.translation(in: self.view)
            v.center = CGPoint(x: v.center.x + translation.x, y: v.center.y + translation.y)
            pan.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    @IBAction func btn_colse(_ sender: UIButton) {
        
        self.textBackView.isHidden = true
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
    
    
    
    @IBAction func oneAct(_ sender: UIButton) {
        
               backView.addSubview(object1)
               backPanel.addSubview(object2)
               backView.addSubview(backPanel)
               backView.addSubview(textBackView)
               backView.addSubview(viewEmail)
               let yourImage = UIImage(named: "123456")

               object1.addImage(selectedImage: yourImage!)
               
               //Modify the Label
               //        stickerView.textColor = UIColor.green
               //        stickerView.textAlpha = 1
               object1.currentlyEditingLabel.closeView!.image = UIImage(named: "cancel")
               object1.currentlyEditingLabel.rotateView?.image = UIImage(named: "rotate-option")
               object1.currentlyEditingLabel.border?.strokeColor = UIColor.white.cgColor
               object1.currentlyEditingLabel.labelTextView?.becomeFirstResponder()
    }
    
    
    
    @IBAction func twoAct(_ sender: UIButton) {
        object2.image = UIImage(named: "frame_35")

    }
    
    
    
    @IBAction func threeAct(_ sender: UIButton) {
        let image = backView.renderContentOnView()
        yourImage.image = image

    }
    
    
    @IBAction func fourAct(_ sender: UIButton) {
        object2.image = UIImage(named: "")
        object2.image = UIImage(named: "frame_61")
    }
    
    
 
}
