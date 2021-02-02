//
//  LeaderboardTableViewCell.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-26.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewParent.roundCornerWithShadow()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configXIB(data: XIBLeaderboard){

    }
    
}
