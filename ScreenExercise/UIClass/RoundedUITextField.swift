//
//  RoundedUITextField.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit

class RoundedUITextField: UITextField {

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

}
