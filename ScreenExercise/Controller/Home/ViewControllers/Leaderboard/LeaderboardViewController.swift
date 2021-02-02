//
//  LeaderboardViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-26.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var dashboardView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tblLeaderboard: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    
    var ranks : [XIBLeaderboard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView.roundCornerWithOutLine()
        headerImageView.roundImageViewForXIB()

        tblLeaderboard.register(UINib(nibName: XIBIdentifier.XIB_LEADERBOARD, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_LEADERBOARD_CELL)
        tblLeaderboard.tableFooterView = nil
        tblLeaderboard.tableHeaderView = tableHeaderView
        
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
        ranks.append(XIBLeaderboard(dummy: "a"))
    }
    

}

extension LeaderboardViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblLeaderboard.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_LEADERBOARD_CELL, for: indexPath) as! LeaderboardTableViewCell
               cell.configXIB(data: ranks[indexPath.row])
               
               cell.alpha = 0
               UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                   cell.alpha = 1
               })
               
               return cell
    }
}

