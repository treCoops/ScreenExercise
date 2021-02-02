//
//  EditActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit

class EditActivityViewController: UIViewController {

    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDescription.clipsToBounds = true;
        txtDescription.layer.cornerRadius = 5;


    }
    
}
