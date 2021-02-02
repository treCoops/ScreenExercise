//
//  CustomTextFieldPlaceholder.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit

class CustomTextFieldPlaceholder: UITextField {

   

}

extension UITextField{
           @IBInspectable var placeHolderColor: UIColor? {
               get {
                   return self.placeHolderColor
               }
               set {
                   self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ?
       self.placeholder! : "",
       attributes:[NSAttributedString.Key.foregroundColor : newValue!])
               }
           }
}

