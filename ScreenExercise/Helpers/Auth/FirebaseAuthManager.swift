//
//  FirebaseAuth.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-03.
//

import Foundation
import Firebase

class FirebaseAuthManager{
    var delagate : FirebaseActions?
    
    func signUpViaPhoneNumber(phoneNumber: String){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error.localizedDescription)
                self.delagate?.numberVerificationFailed(error: error)
                return
              }
            
              self.delagate?.numberVerificationSuccess(verificationID: verificationID!)
         
        }
    }
    
    func signInViaPhoneNumber(verificationID: String, verificationCode: String){
        let credential = PhoneAuthProvider.provider().credential( withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            self.delagate?.operationFailed(error: error)
            return
          }
        
          self.delagate?.operationSuccess(msg: authResult?.user.uid ?? "no")
        }
    }
}

protocol FirebaseActions {
    
    func numberVerificationSuccess(verificationID: String)
    func numberVerificationFailed(error: Error)
    
    func operationSuccess(msg: String)
    func operationFailed(error: Error)
}

extension FirebaseActions{
    
    func numberVerificationSuccess(verificationID: String){}
    func numberVerificationFailed(error: Error){}
    
    func operationSuccess(msg: String){}
    func operationFailed(error: Error){}
}

