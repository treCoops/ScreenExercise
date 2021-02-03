//
//  RoundedUITextField.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit

class RoundedUITextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {

        layer.cornerRadius = 5
        layer.masksToBounds = true
//        layer.borderWidth = 0.9
//        layer.borderColor = #colorLiteral(red: 0.1450980392, green: 0.7960784314, blue: 0.6509803922, alpha: 1)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
       if action == #selector(UIResponderStandardEditActions.paste(_:)) {
           return false
       }
       return super.canPerformAction(action, withSender: sender)
    }

}
