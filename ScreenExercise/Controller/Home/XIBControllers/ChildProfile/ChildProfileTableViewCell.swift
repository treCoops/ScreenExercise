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
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtPendingCount: UILabel!
    @IBOutlet weak var txtCompletedCount: UILabel!
    @IBOutlet weak var txtIncompletedCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        parentView.roundCornerWithShadow()
        lblStatus.roundCorners(.allCorners, radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configXIB(data: XIBChildProfile){
        
        txtName.text = data.name
        if(data.active){
            lblStatus.isHidden = false
        }else{
            lblStatus.isHidden = true
        }
        txtName.text = data.name
        txtPendingCount.text = String(data.pending)
        txtCompletedCount.text = String(data.completed)
        txtIncompletedCount.text = String(data.incompleted)
    }
    
}
