//
//  maxLengthTextField.swift
//  ExoticBasketNewPro
//
//  Created by ABDUL KADIR ANSARI on 05/06/21.
//  Copyright © 2021 ABDUL KADIR ANSARI. All rights reserved.
//

import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLengthTextField: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLengthTextField)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        let c1 = self
        if (c1.count <= n) { return self }
        return String( Array(c1).prefix(upTo: n) )
    }
}

// **  MARK ROUND COURNERS 
extension UIView {
    func mainViewRoundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
    }
    
}
// **  MARK UIVIEW  CARDVIEW
@IBDesignable
class CardView: UIView {
    @IBInspectable var corner_Radius: CGFloat = 10
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadow_Color: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5
    override func layoutSubviews() {
        layer.cornerRadius = corner_Radius
       // let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: corner_Radius)
        layer.masksToBounds = false
        layer.shadowColor = shadow_Color?.cgColor
     //   layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
       // layer.shadowPath = shadowPath.cgPath
    }
}

// **  MARK TEXT FILED CARDVIEW

@IBDesignable
class TexfiledCardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
