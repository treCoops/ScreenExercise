//
//  UserRegistrationViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit

import Firebase
import Kingfisher


class UserRegistrationViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        
        if user != nil {
            txtName.text = user?.displayName
            txtEmailAddress.text = user?.email
            imgProfile.kf.setImage(with: user?.photoURL)
        } else {
          
        }


    }
    
    

}
