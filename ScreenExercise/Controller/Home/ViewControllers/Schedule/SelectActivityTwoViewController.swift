//
//  SelectActivityTwoViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit
import iOSDropDown
import RealmSwift

class SelectActivityTwoViewController: UIViewController {

    @IBOutlet weak var tblCustomActivities: UITableView!
    @IBOutlet weak var colCategory: UICollectionView!
    @IBOutlet weak var cmbCategory: DropDown!
    
    var categories : [XIBCategoryTwo] = []
    
    var customActivities : [XIBCustomSchedule] = []
    var customActivitiesDB : Results<CustomActivity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCustomActivities.register(UINib(nibName: XIBIdentifier.XIB_CUSTOM_SCHEDULE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CUSTOM_SCHEDULE_CELL)
        
        cmbCategory.optionArray = DropdownArray.cmbCategory
       
        registerNib()
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
        categories.append(XIBCategoryTwo(dummy: "ab"))
      
        
        getDataForTableView()
        
        self.colCategory.reloadData()

   
    }
    @IBAction func btnCreateCustomActivityPressed(_ sender: UIButton) {
        
    }
    
    func getDataForTableView(){
        customActivities.removeAll()
        
        
        let realm = try! Realm()
        
        customActivitiesDB = realm.objects(CustomActivity.self)
        
        for activity in customActivitiesDB {
            
//            customActivities.append(XIBCustomSchedule(id: activity.activityID, activityName: activity.activityName, activityDescription: activity.activityDescription))
            customActivities.append(XIBCustomSchedule(id: activity.activityID, activityName: activity.activityName, activityDescription: activity.activityDescription, timeSlotId: activity.timeSlotId, childID: activity.childId))
        }
        
        tblCustomActivities.reloadData()
        
        
    }

    func registerNib() {
        let nib = UINib(nibName: XIBIdentifier.NIB_NAME_CATEGORY_CLASS_TWO, bundle: nil)
        self.colCategory?.register(nib, forCellWithReuseIdentifier: XIBIdentifier.XIB_CATEGORY_CELL_TWO)
        if let flowLayout = self.colCategory?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 4, height: 4)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataForTableView()
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectActivityTwoViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = colCategory.dequeueReusableCell(withReuseIdentifier: XIBIdentifier.XIB_CATEGORY_CELL_TWO, for: indexPath) as? CategoryTwoCollectionViewCell {
            cell.configureCell(Data: categories[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SpecificActivitySegue", sender: self)
    }
    
}

extension SelectActivityTwoViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: CategoryTwoCollectionViewCell = Bundle.main.loadNibNamed(XIBIdentifier.NIB_NAME_CATEGORY_CLASS_TWO, owner: self, options: nil)?.first as? CategoryTwoCollectionViewCell else {
            return CGSize.zero
        }
        
        cell.configureCell(Data: categories[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let _: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return CGSize(width: ( self.colCategory.frame.size.width - 50 ) / 2,height:( self.colCategory.frame.size.width - 20 ) / 2)
        
//        return CGSize(width: 100, height: 100)
    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 20
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 20;
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
    
}

extension SelectActivityTwoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCustomActivities.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_CUSTOM_SCHEDULE_CELL, for: indexPath) as! CustomScheduleTableViewCell
               cell.configXIB(data: customActivities[indexPath.row])
               
               cell.alpha = 0
               UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                   cell.alpha = 1
               })
               
               return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "ViewFromSelectActivityTwoSegue", sender: self)
    }
    
}

extension SelectActivityTwoViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewFromSelectActivityTwoSegue" {

            if let indexPath = self.tblCustomActivities.indexPathForSelectedRow {
                var id: String
                if (self.tblCustomActivities == self.searchDisplayController?.searchResultsTableView) {
                    id = customActivities[indexPath.row].id
                    print(id)
                } else {
                    id = customActivities[indexPath.row].id
                    print(id)
                }
                (segue.destination as! CustomActivityViewController).activityID = id
            }
        }
        
//        if segue.identifier == "SagueCreateCustomActivityTwo" {
//            (segue.destination as! CreateActivityViewController).timeSlotID = //ChildTimeSlot
//        }
    }
}

