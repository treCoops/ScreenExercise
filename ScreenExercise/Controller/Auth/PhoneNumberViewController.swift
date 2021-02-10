//
//  PhoneNumberViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    var firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPhoneNumber.delegate = self

        firebaseAuthManager.delagate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func btnContinuePressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "PhoneToOTPSegue", sender: self)
        
        if(Validator.isEmpty(txtPhoneNumber.text ?? "")){
            AlertBar.danger(title: "Please enter your phone number.")
            return
        }

        if(Validator.checkLenght(txtPhoneNumber.text ?? "", 12)){
            AlertBar.danger(title: "Please enter valid phone number.")
            return
        }

        firebaseAuthManager.signUpViaPhoneNumber(phoneNumber: txtPhoneNumber.text ?? "")
    }
    
    
    
}

extension PhoneNumberViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
}

extension PhoneNumberViewController : FirebaseActions {
    
    func numberVerificationSuccess(verificationID: String) {
        UserSession.setAuthVerificationID(data: verificationID, key: UserSessionKey.KEY_VERIFICATION_ID)
        
        performSegue(withIdentifier: "PhoneToOTPSegue", sender: self)
    }
    
    func numberVerificationFailed(error: Error) {
        if(error.localizedDescription == "TOO_SHORT"){
            AlertBar.danger(title: "Invalid Phone Number")
        }
        
    }
}
