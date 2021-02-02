//
//  ScheduleTableViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-12.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var txtStatus: UILabel!
    
    @IBAction func btnAddClicked(_ sender: UIButton) {
        print("asd")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewParent.roundCornerWithShadow()
        
        txtStatus.layer.cornerRadius = 5
        txtStatus.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configXIB(data: XIBSchedule){

    }
    
}
