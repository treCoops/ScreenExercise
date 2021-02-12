//
//  AddChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-27.
//

import UIKit
import DLRadioButton
import RealmSwift

class AddChildProfileViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imgChildProfilePicture: RoundedImageView!
    @IBOutlet weak var txtChildName: UITextField!
    @IBOutlet weak var txtChildNickName: UITextField!
    @IBOutlet weak var txtChildAge: UITextField!
    @IBOutlet weak var rdbMale: DLRadioButton!
    
    var alert : UIAlertController!
    
    let imagePicker = UIImagePickerController()
    
    var gender : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rdbMale.isSelected = true
        self.gender = "Male"
        
        txtChildAge.delegate = self
        txtChildNickName.delegate = self
        txtChildName.delegate = self
        
        imagePicker.delegate = self
        
        
        createAlertDialog()
       

    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func btnImageSelectPressed(_ sender: UIButton) {
        self.present(alert, animated: true)

    }
    
    @IBAction func rdnRadioButtonSelected(_ sender: DLRadioButton) {
        if (sender.isMultipleSelectionEnabled) {
               for button in sender.selectedButtons() {
                    self.gender = button.titleLabel!.text!
               }
           } else {
            self.gender = sender.selected()!.titleLabel!.text!
           }
    }
    
    @IBAction func btnCreadeChildProfilePressed(_ sender: UIButton) {
        if(Validator.isEmpty(txtChildName.text ?? "")){
            AlertBar.danger(title: "Please enter your child name.")
            return
        }
        
        if(!Validator.isValidName(txtChildName.text ?? "")){
            AlertBar.danger(title: "Invalid child name.")
            return
        }
        
        if(Validator.isEmpty(txtChildNickName.text ?? "")){
            AlertBar.danger(title: "Please enter your child nick name.")
            return
        }
        
        if(!Validator.isValidName(txtChildName.text ?? "")){
            AlertBar.danger(title: "Invalid child nick name.")
            return
        }
        
        if(Validator.isEmpty(txtChildAge.text ?? "")){
            AlertBar.danger(title: "Please enter your child age.")
            return
        }
        
        if(!Validator.isNumber(txtChildAge.text ?? "")){
            AlertBar.danger(title: "Invalid child age.")
            return
        }
        
        let childProfile = ChildProfile()
        childProfile.childName = txtChildName.text!
        childProfile.childNickName = txtChildNickName.text!
        childProfile.childAge = Int(txtChildAge.text!) ?? 0
        childProfile.childGender = self.gender
        
        self.add(child: childProfile)
        
//        if let imgData = self.imgChildProfilePicture.image!.jpegData(compressionQuality: 0.5) {
//            // Storing image in documents folder (Swift 2.0+)
//            var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//            let writePath: () = documentsPath.append(contentsOf: "abc")
//
//            imgData.writeToFile(writePath, atomically: true)
//
//            var mystorage = MyImageStorage()
//            mystorage.imagePath = writePath
//
//            let realm = try! Realm()
//            try! realm.write {
//                 realm.add(mystorage)
//            }
//        }

        
//        let data = NSData(data: self.imgChildProfilePicture.image!.jpegData(compressionQuality: 0.5)!)
//        let imgPNG = UIImage(data: data as Data)!
//
//        let dataPNGImg = NSData(data: imgPNG.pngData()!)
//
//        childProfile.profileImage = dataPNGImg
        
        
    }
}

extension AddChildProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
}

extension AddChildProfileViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imgChildProfilePicture.image = pickedImage
            }
            
            dismiss(animated: true, completion: nil)
        }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
}


extension AddChildProfileViewController {
    func add(child: ChildProfile){
        
        let realm = try! Realm()
        
        let eventResults = realm.objects(ChildProfile.self).filter("childName contains[cd] %@ and childNickName contains[cd] %@", child.childName, child.childNickName)
        
        if (eventResults.count != 0) {
            AlertBar.warning(title: "This child is already exists!")
        } else {
            try! realm.write{
                realm.add(child)
                AlertBar.success(title: "Child profile has been added!")
            }
        }
            
      
    }
}
