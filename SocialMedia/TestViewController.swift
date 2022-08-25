//
//  TestViewController.swift
//  SocialMedia
//
//  Created by Abdul on 12/05/22.
//

import UIKit
import StickerView

class TestViewController: UIViewController {

    @IBOutlet weak var backview: JLStickerImageView!
    
    @IBOutlet weak var raju: JLStickerImageView!
    
    @IBOutlet weak var shaker: UIImageView!
    
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
        
        raju.sizeToFit()
        raju.isUserInteractionEnabled = true
        backview.addSubview(raju)
        backview.addSubview(shaker)

        
        //backView.addSubview(object1)
        
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(recognizer:)))
        raju.addGestureRecognizer(pan)

    }
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @IBAction func frame_BtnActn(_ sender: UIButton) {
        let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        testImage.image = UIImage(named: "1-2")
        testImage.contentMode = .scaleAspectFit
        let stickerView3 = StickerView.init(contentView: testImage)
        stickerView3.center = CGPoint.init(x: 150, y: 150)
        stickerView3.delegate = self
        stickerView3.setImage(UIImage.init(named: "close1")!, forHandler: StickerViewHandler.close)
        stickerView3.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
        stickerView3.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.flip)
        stickerView3.showEditingHandlers = false
        stickerView3.tag = 999
        self.raju.addSubview(stickerView3)
        self.selectedStickerView = stickerView3
    }
    
    
    @IBAction func image_btnActtn(_ sender: UIButton) {
    }
    
}
extension TestViewController : StickerViewDelegate {
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
