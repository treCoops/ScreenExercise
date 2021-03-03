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
    var indicatorHUD : IndicatorHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorHUD = IndicatorHUD(view: view)
        txtOTP.delegate = self

        firebaseAuthManager.delagate = self
    }
    @IBAction func btnResendOTPPressed(_ sender: UIButton) {
        self.getOTP()
    }
    
    @IBAction func btnGetStartedPressed(_ sender: UIButton) {
        self.getOTP()
    }
    
    func getOTP(){
        
        if(Validator.isEmpty(txtOTP.text ?? "")){
            AlertBar.danger(title: "Please enter the verification code.")
            return
        }

        if(Validator.checkLenght(txtOTP.text ?? "", 6)){
            AlertBar.danger(title: "Invalid verification code. Code must have 6 digits only.")
            return
        }
        
        indicatorHUD.show()
        
        firebaseAuthManager.signInViaPhoneNumber(verificationID: UserSession.getUserDefault(key: UserSessionKey.KEY_VERIFICATION_ID)!, verificationCode: txtOTP.text!)
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
        indicatorHUD.hide()
        performSegue(withIdentifier: "segueToSignInForm", sender: self)
    }
    
    func operationFailed(error: Error) {
        print(error)
        indicatorHUD.hide()
        AlertBar.danger(title: error.localizedDescription)
    }
}

