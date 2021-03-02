//
//  SelectActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit
import RealmSwift

class SelectActivityViewController: UIViewController {
    @IBOutlet weak var categoryColloctionView: UICollectionView!
    @IBOutlet weak var tblCustomActivities: UITableView!
    
    var timeSlotID : String = ""
    
    var categories : [XIBCategory] = []
    var categoriesDB : Results<Category>!
    
    var customActivities : [XIBCustomSchedule] = []
    var customActivitiesDB : Results<CustomActivity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCustomActivities.register(UINib(nibName: XIBIdentifier.XIB_CUSTOM_SCHEDULE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CUSTOM_SCHEDULE_CELL)

        registerNib()
      
        getCategories()
        getDataForTableView()
    }
    
    func getCategories(){
        categories.removeAll()
        
        let realm = try! Realm()
        categoriesDB = realm.objects(Category.self)
        
        for cate in categoriesDB {
            categories.append(XIBCategory(id: cate.id, name: cate.name, image: cate.image, type: cate.type))
        }
        
        self.categoryColloctionView.reloadData()
    }
    
    func getDataForTableView(){
        customActivities.removeAll()
        
        
        let realm = try! Realm()
        
        customActivitiesDB = realm.objects(CustomActivity.self)
        
        for activity in customActivitiesDB {
            
            customActivities.append(XIBCustomSchedule(id: activity.activityID, activityName: activity.activityName, activityDescription: activity.activityDescription, timeSlotId: activity.timeSlotId, childID: activity.childId))

        }
        
        tblCustomActivities.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataForTableView()
    }
    
    func registerNib() {
        let nib = UINib(nibName: XIBIdentifier.NIB_NAME_CATEGORY_CLASS, bundle: nil)
        self.categoryColloctionView?.register(nib, forCellWithReuseIdentifier: XIBIdentifier.XIB_CATEGORY_CELL)
        if let flowLayout = self.categoryColloctionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 4, height: 4)
        }
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCreateCustomActivityPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SagueCreateCustomActivity", sender: self)
    }
}


extension SelectActivityViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryColloctionView.dequeueReusableCell(withReuseIdentifier: XIBIdentifier.XIB_CATEGORY_CELL, for: indexPath) as? CategoryCollectionViewCell {
            cell.configureCell(Data: categories[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ActivitySegue", sender: self)
        
    }
    
   
    
}

extension SelectActivityViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewFromSelectActivitySegue" {

            if let indexPath = self.tblCustomActivities.indexPathForSelectedRow {
                (segue.destination as! CustomActivityViewController).activityID = customActivities[indexPath.row].id
            }
        }
        
        if segue.identifier == "SagueCreateCustomActivity" {
            (segue.destination as! CreateActivityViewController).timeSlotID = self.timeSlotID
        }
        
        if segue.identifier == "ActivitySegue" {

            
            if let indexPath = self.categoryColloctionView.indexPathsForSelectedItems?.first {
                
                (segue.destination as! SelectActivityTwoViewController).refDictionary = ["timeSlotID": self.timeSlotID, "categoryID": categories[indexPath.row].id]
            }
            
        }
    }
}

extension SelectActivityViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: CategoryCollectionViewCell = Bundle.main.loadNibNamed(XIBIdentifier.NIB_NAME_CATEGORY_CLASS, owner: self, options: nil)?.first as? CategoryCollectionViewCell else {
            return CGSize.zero
        }
        
        cell.configureCell(Data: categories[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let _: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return CGSize(width: ( self.categoryColloctionView.frame.size.width - 50 ) / 3,height:( self.categoryColloctionView.frame.size.width - 20 ) / 3)
        
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

extension SelectActivityViewController : UITableViewDelegate, UITableViewDataSource {
    
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
         performSegue(withIdentifier: "ViewFromSelectActivitySegue", sender: self)
    }
}
