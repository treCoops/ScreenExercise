//
//  CategoryTwoCollectionViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit
import Lottie


class CategoryTwoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewParent: UIView!
    @IBOutlet var animationView: AnimationView!
    @IBOutlet var txtActivityName: UILabel!
    @IBOutlet var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        viewParent.roundCornerWithShadow()
        btnAdd.alpha = 0
    }
    
    func configureCell(Data: XIBCategoryTwo) {
        txtActivityName.text = Data.name
        
        animationView.roundCorner(.allCorners, radius: 20)
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
           let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("ScreenExercise/\(Data.fileName)") {
            let filePath = pathComponent.path
               let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                    let animation = Animation.filepath(filePath)
                    animationView.animation = animation
                    animationView.contentMode = .scaleToFill
                    animationView.backgroundBehavior = .pauseAndRestore
                    animationView!.loopMode = .loop
                    animationView!.animationSpeed = 1
//                    animationView.play()

               } else {
                   print("FILE NOT AVAILABLE")
               }
           } else {
               print("FILE PATH NOT AVAILABLE")
           }
        
    }
    
    
}
