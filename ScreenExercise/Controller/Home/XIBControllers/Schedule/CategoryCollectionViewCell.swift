//
//  CategoryCollectionViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewParent: CustomRoundedView!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewParent.roundCornerWithShadowCollectionViewCell()
        imgCategory.roundImageForCollectionView()

    }
    
    func configureCell(Data: XIBCategory){
        lab.text = Data.name
        imgCategory.kf.setImage(with: URL(string: Data.image))
    }
}
