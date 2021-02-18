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
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtTask: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
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
        txtTime.text = data.time
        if(data.isAssigned){
            txtTask.text = data.task
            txtTask.textColor = #colorLiteral(red: 0.4039215686, green: 0.4470588235, blue: 0.4823529412, alpha: 1)
            btnAdd.setImage(#imageLiteral(resourceName: "dummy"), for: .normal)
            if(data.isAssigned && data.completeStatus=="Pending"){
                txtStatus.text = " \(data.completeStatus) "
                txtStatus.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            }
        }else{
            txtTask.text = "Press “+” button to add activity"
            txtTask.textColor = #colorLiteral(red: 0.8, green: 0.8156862745, blue: 0.831372549, alpha: 1)
            btnAdd.setImage(#imageLiteral(resourceName: "add"), for: .normal)
            txtStatus.text = " Not Scheduled "
            txtStatus.backgroundColor = #colorLiteral(red: 0.8, green: 0.8156862745, blue: 0.831372549, alpha: 1)
        }
    }
    
}
