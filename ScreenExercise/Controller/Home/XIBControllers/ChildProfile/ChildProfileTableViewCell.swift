//
//  ChildProfileTableViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-27.
//

import UIKit

class ChildProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        parentView.roundCornerWithShadow()
        lblStatus.roundCorners(.allCorners, radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configXIB(data: XIBChildProfile){

    }
    
}
