//
//  SearchUIView.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit

class SearchUIView: UIView {

    override func layoutSubviews() {
       super.layoutSubviews()

        self.roundCorner([.allCorners], radius: 10)
    }

}

extension UIView {

    func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
