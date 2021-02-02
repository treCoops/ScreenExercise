//
//  HomeUITabBarController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-12.
//

import UIKit

class HomeUITabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY - 22, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height + 55), cornerRadius: (self.tabBar.frame.width/16)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        let appearance = self.tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        self.tabBar.standardAppearance = appearance;
     
        
        if let items = self.tabBar.items {
          items.forEach { item in item.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: -5, right: 0) }
        }

//        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .centered
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
    }
    



}
