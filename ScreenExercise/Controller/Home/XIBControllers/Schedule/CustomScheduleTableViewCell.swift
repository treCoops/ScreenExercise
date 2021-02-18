//
//  CustomScheduleTableViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit

class CustomScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var txtActivityName: UILabel!
    @IBOutlet weak var txtActivityDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewParent.roundCornerWithShadow()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configXIB(data: XIBCustomSchedule){
        txtActivityName.text = data.activityName
        txtActivityDescription.text = data.activityDescription
    }
}
