//
//  SelectActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-13.
//

import UIKit

class SelectActivityViewController: UIViewController {
    @IBOutlet weak var categoryColloctionView: UICollectionView!
    @IBOutlet weak var tblCustomActivities: UITableView!
    
    var categories : [XIBCategory] = []
    var customActivities : [XIBCustomSchedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCustomActivities.register(UINib(nibName: XIBIdentifier.XIB_CUSTOM_SCHEDULE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CUSTOM_SCHEDULE_CELL)
        
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))
        customActivities.append(XIBCustomSchedule(dummy: "a"))

        registerNib()
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
        categories.append(XIBCategory(dummy: "ab"))
      
        
        self.categoryColloctionView.reloadData()

    }
    
    
    func registerNib() {
        let nib = UINib(nibName: XIBIdentifier.NIB_NAME_CATEGORY_CLASS, bundle: nil)
        self.categoryColloctionView?.register(nib, forCellWithReuseIdentifier: XIBIdentifier.XIB_CATEGORY_CELL)
        if let flowLayout = self.categoryColloctionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 4, height: 4)
        }
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
}
