//
//  UserRegistrationViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit

import Firebase
import Kingfisher
import DLRadioButton


class UserRegistrationViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet var txtPhoneNumber: UITextField!
    
    var indicatorHUD : IndicatorHUD!
    
    var firebaseAuthManager = FirebaseAuthManager()
    
    var alert : UIAlertController!
    
    let imagePicker = UIImagePickerController()
    
    var apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorHUD = IndicatorHUD(view: view)
        firebaseAuthManager.delagate = self
        apiHelper.delagate = self
        
        txtEmailAddress.delegate = self
        txtName.delegate = self
        txtPhoneNumber.delegate = self
        
        imagePicker.delegate = self
        createAlertDialog()
        
        txtPhoneNumber.isUserInteractionEnabled = false
        
        let user = Auth.auth().currentUser
        
        if user != nil {
            txtName.text = user?.displayName
            txtEmailAddress.text = user?.email
            imgProfile.kf.setImage(with: user?.photoURL)
            txtPhoneNumber.text = user?.phoneNumber
        }

    }
    @IBAction func btnImagePressed(_ sender: UIButton) {
        self.present(alert, animated: true)
    }
    
    @IBAction func btnContinuePressed(_ sender: UIButton) {
        
        
        if(Validator.isEmpty(txtName.text ?? "")){
            AlertBar.danger(title: "Please enter your name.")
            return
        }
        
        if(!Validator.isValidName(txtName.text ?? "")){
            AlertBar.danger(title: "Invalid name.")
            return
        }
        
        if(Validator.isEmpty(txtPhoneNumber.text ?? "")){
            AlertBar.danger(title: "Please enter your contact number.")
            return
        }

        if(Validator.checkLenght(txtPhoneNumber.text ?? "", 12)){
            AlertBar.danger(title: "Please enter valid contact number.")
            return
        }
        
        if(Validator.isEmpty(txtEmailAddress.text ?? "")){
            AlertBar.danger(title: "Please enter your email address.")
            return
        }
        
        if(!Validator.isValidEmail(txtEmailAddress.text ?? "")){
            AlertBar.danger(title: "Invalid email.")
            return
        }
        
        
        let User = [
            "uid": Auth.auth().currentUser?.uid ?? " ",
            "fullName": self.txtName.text!,
            "emailAddress": txtEmailAddress.text!,
            "profileUrl": "url"
        ] as [String : Any]
        
        indicatorHUD.show()
        firebaseAuthManager.updateUserFromPhoneNumber(image: (imgProfile.image ?? UIImage.init(named: "profilePicDummy")!), data: User)
        
        
    }
    
    func substring(value: String, point: Int) -> String {
        let substring = value.dropFirst(point)
        let realString = String(substring)
        return realString
    }
    
}

extension UserRegistrationViewController : FirebaseActions {
    func operationSuccess(msg: String) {
        print(msg)
        apiHelper.createUser(name: self.txtName.text!, email: txtEmailAddress.text!, phone: "0\(self.substring(value: txtPhoneNumber.text!, point: 3))", type: "1", comments: "This is test", provider: "Dialog")
    }
    
    func operationFailed(error: Error) {
        print(error)
        indicatorHUD.hide()
        AlertBar.danger(title: error.localizedDescription)
    }
}

extension UserRegistrationViewController : API {
    
    func response(status: Int, message: String, user: User){
        if(status == 200){
            UserSession.setInt(data: user.id, key: UserSessionKey.ACTIVED_CHILD_ID)
            UserSession.set(data: true, key: UserSessionKey.USER_LOGGED)
            indicatorHUD.hide()
            performSegue(withIdentifier: "SegueToSubcription", sender: self)
        }
        else{
            AlertBar.danger(title: message)
        }
    }
    
    func error(error: Error){
        indicatorHUD.hide()
    }
}


extension UserRegistrationViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
}


extension UserRegistrationViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imgProfile.image = pickedImage
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


