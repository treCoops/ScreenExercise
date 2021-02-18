//
//  ChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-27.
//

import UIKit
import RealmSwift

class ChildProfileViewController: UIViewController {

    @IBOutlet weak var tblChilds: UITableView!
    
    var childs : [XIBChildProfile] = []
    var childProfiles : Results<ChildProfile>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblChilds.register(UINib(nibName: XIBIdentifier.XIB_CHILD_PROFILE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CHILD_PROFILE_CELL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getDataForTableView()
    }
    
    func getDataForTableView(){
        
        childs.removeAll()
        
        let realm = try! Realm()
        childProfiles = realm.objects(ChildProfile.self)
        
        for child in childProfiles {
            
            childs.append(XIBChildProfile(id: child.childID, name: child.childName, active: child.isActive, profilePic: "asd", pending: child.taskPending, completed: child.taskCompleted, incompleted: child.taskIncompleted))

        }
        
        tblChilds.reloadData()
        
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
        
        let clearView = UIView()
        UIView().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = clearView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "ChildProfileItemSegue", sender: self)
    }
    
}

extension ChildProfileViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChildProfileItemSegue" {

            if let indexPath = self.tblChilds.indexPathForSelectedRow {
                var id: String
                if (self.tblChilds == self.searchDisplayController?.searchResultsTableView) {
                    id = childs[indexPath.row].id
                } else {
                    id = childs[indexPath.row].id
                }
                (segue.destination as! ViewChildProfileViewController).childID = id
            }
        }
    }
}


