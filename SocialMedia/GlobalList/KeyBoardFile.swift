//
//  KeyBoardFile.swift
//  jewelmaxMainProject
//
//  Created by ABDUL KADIR ANSARI on 09/02/21.
//  Copyright © 2021 ABDUL KADIR ANSARI. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



