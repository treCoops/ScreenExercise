//
//  OTPViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit
import Firebase

class OTPViewController: UIViewController {

    @IBOutlet weak var txtOTP: UITextField!
    
    var firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOTP.delegate = self

        firebaseAuthManager.delagate = self
    }
    
    @IBAction func btnGetStartedPressed(_ sender: UIButton) {
        
        if(Validator.isEmpty(txtOTP.text ?? "")){
            AlertBar.danger(title: "Please enter the verification code.")
            return
        }

        if(Validator.checkLenght(txtOTP.text ?? "", 6)){
            AlertBar.danger(title: "Invalid verification code. Code must have 6 digits only.")
            return
        }
        
        firebaseAuthManager.signInViaPhoneNumber(verificationID: UserSession.getUserDefault(key: UserSessionKey.KEY_VERIFICATION_ID)!, verificationCode: txtOTP.text!)
        
//        OTPToUserRegistration
    }
    
}

extension OTPViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    
}



extension OTPViewController : FirebaseActions {
    func operationSuccess(msg: String) {
        AlertBar.success(title: msg)
    }
    
    func operationFailed(error: Error) {
        print(error)
        AlertBar.danger(title: error.localizedDescription)
    }
}

