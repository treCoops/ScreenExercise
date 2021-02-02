//
//  CornerRoundImageView.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit

class CornerRoundImageView : UIImageView {
    
    override func layoutSubviews() {
       super.layoutSubviews()

       self.squareImageView()
    }

  

}

extension UIImageView{
    
    func squareImageView(){
         self.layer.cornerRadius = self.frame.height / 64
         self.clipsToBounds = true
    }
}

