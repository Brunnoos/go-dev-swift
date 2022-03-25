//
//  UITextFieldExtensions.swift
//  LoginRework
//
//  Created by Idwall Go Dev 008 on 24/03/2022
//
// Adapted by Bruno Oliveira on 24/03/2022

import Foundation
import UIKit

extension UITextField {
    func addPaddingLeft(_ value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addPaddingRight(_ value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
