//
//  EditChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit
import DLRadioButton
import RealmSwift

class EditChildProfileViewController: UIViewController, UINavigationControllerDelegate {

    public var childProfile : ChildProfile!
    @IBOutlet weak var txtChildName: UITextField!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var rdnMale: DLRadioButton!
    @IBOutlet weak var rdnFemale: DLRadioButton!
    @IBOutlet weak var imgChildProfilePic: UIImageView!
    
    var alert : UIAlertController!
    
    var gender : String = ""
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillForm(child: childProfile)
        
        txtAge.delegate = self
        txtNickName.delegate = self
        txtChildName.delegate = self
        
        gender = childProfile.childGender
   
        imagePicker.delegate = self
        
        createAlertDialog()
    }
    
    @IBAction func btnProfilePictureButtonPressed(_ sender: UIButton) {
        self.present(alert, animated: true)
    }
    
    func createAlertDialog() {
        alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {_ in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
   
    @IBAction func rdbGender(_ sender: DLRadioButton) {
        if (sender.isMultipleSelectionEnabled) {
               for button in sender.selectedButtons() {
                    self.gender = button.titleLabel!.text!
               }
           } else {
            self.gender = sender.selected()!.titleLabel!.text!
           }
    }
    
    
    @IBAction func btnSavPressed(_ sender: UIButton) {
        if(Validator.isEmpty(txtChildName.text ?? "")){
            AlertBar.danger(title: "Please enter your child name.")
            return
        }
        
        if(!Validator.isValidName(txtChildName.text ?? "")){
            AlertBar.danger(title: "Invalid child name.")
            return
        }
        
        if(Validator.isEmpty(txtNickName.text ?? "")){
            AlertBar.danger(title: "Please enter your child nick name.")
            return
        }
        
        if(!Validator.isValidName(txtNickName.text ?? "")){
            AlertBar.danger(title: "Invalid child nick name.")
            return
        }
        
        if(Validator.isEmpty(txtAge.text ?? "")){
            AlertBar.danger(title: "Please enter your child age.")
            return
        }
        
        if(!Validator.isNumber(txtAge.text ?? "")){
            AlertBar.danger(title: "Invalid child age.")
            return
        }
        
        let child = ChildProfile()
        child.childName = txtChildName.text!
        child.childNickName = txtNickName.text!
        child.childAge = Int(txtAge.text!) ?? 0
        child.childGender = self.gender
        
        self.updateChild(child: child)
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func updateChild(child: ChildProfile){
        let realm = try! Realm()
        
        let result = realm.objects(ChildProfile.self).filter("childID = %@", childProfile.childID)
        
        if let childPro = result.first {
            try! realm.write {
                childPro.childAge = child.childAge
                childPro.childName = child.childName
                childPro.childGender = child.childGender
                childPro.childNickName = child.childNickName
            }
        }
        
        AlertBar.success(title: "Child profile has been updated!")
    }

    @IBAction func onDeleteChildProfilePressed(_ sender: UIButton) {
        
        PopupDialogViewController.showPopup(parentVC: self, from: "EDITCHILD>\(childProfile.childID)")
    }
    
    func fillForm(child: ChildProfile){
        if(child.childGender == "Male"){
            rdnMale.isSelected = true
        }
        
        if(child.childGender == "Female"){
            rdnFemale.isSelected = true
        }
        
        txtNickName.text = child.childNickName
        txtAge.text = String(child.childAge)
        txtChildName.text = child.childName
    }
    
    public func popupDidDisappear() {
        print("ds")
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditChildProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
}

extension EditChildProfileViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imgChildProfilePic.image = pickedImage
            }
            
            dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


