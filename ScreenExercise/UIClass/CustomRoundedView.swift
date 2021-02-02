//
//  CustomRoundedView.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit

class CustomRoundedView: UIView {

    override func layoutSubviews() {
       super.layoutSubviews()

       self.roundCorners([.allCorners], radius: 15)
    }

}

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    func roundCornerWithShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 20
        self.layer.cornerRadius = 20
    }
    
    func roundCornerWithOutLine(){
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 0.3098039216, green: 0.4745098039, blue: 0.537254902, alpha: 1)
    }

}
