//
//  CategoryCollectionViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewParent: CustomRoundedView!
    @IBOutlet weak var lab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        viewParent.roundCornerWithShadow()
    }
    
    func configureCell(Data: XIBCategory) {
       
    }
}
