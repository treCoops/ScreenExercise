//
//  ChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-27.
//

import UIKit

class ChildProfileViewController: UIViewController {

    @IBOutlet weak var tblChilds: UITableView!
    
    var childs : [XIBChildProfile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblChilds.register(UINib(nibName: XIBIdentifier.XIB_CHILD_PROFILE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CHILD_PROFILE_CELL)
        
        childs.append(XIBChildProfile(dummy: "a"))
        childs.append(XIBChildProfile(dummy: "a"))
        childs.append(XIBChildProfile(dummy: "a"))
        childs.append(XIBChildProfile(dummy: "a"))
        childs.append(XIBChildProfile(dummy: "a"))

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

extension ChildProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblChilds.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_CHILD_PROFILE_CELL, for: indexPath) as! ChildProfileTableViewCell
        cell.configXIB(data: childs[indexPath.row])
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
        
        return cell
    }
    
}
