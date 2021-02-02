//
//  CategoryTwoCollectionViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit

class CategoryTwoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewParent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        viewParent.roundCornerWithShadow()
    }
    
    func configureCell(Data: XIBCategoryTwo) {
       
    }
    
    
}
