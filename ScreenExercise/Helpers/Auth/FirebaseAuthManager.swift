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
    
    func updateUserFromPhoneNumber(image: UIImage, data: Dictionary<String,Any>){
        
        if let uploadImage = image.jpegData(compressionQuality: 0.5){
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            Storage.storage().reference().child("userProfilePics").child(data["uid"] as! String).putData(uploadImage, metadata: metaData) { (metadata, error) in

                Storage.storage().reference().child("userProfilePics").child(data["uid"] as! String).downloadURL { (url, error) in
                    if let error = error {
                        self.delagate?.operationFailed(error: error)
                    }
                    guard let downloadURL = url else {
                        return
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = data["fullName"] as? String
                    changeRequest?.photoURL = downloadURL.absoluteURL
                    changeRequest?.commitChanges { (error) in
                        
                        if let error = error{
                            self.delagate?.operationFailed(error: error)
                        }
                    }
                    self.delagate?.operationSuccess(msg: "Profile Created Successfully")
                }
            }
            
        }
        
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.delagate?.logoutSuccess()
        } catch let signOutError as NSError {
            AlertBar.warning(title: "Error signing out: \(signOutError)")
        }
    }
}

protocol FirebaseActions {
    
    func numberVerificationSuccess(verificationID: String)
    func numberVerificationFailed(error: Error)
    
    func operationSuccess(msg: String)
    func operationFailed(error: Error)
    
    func logoutSuccess()
}

extension FirebaseActions{
    
    func numberVerificationSuccess(verificationID: String){}
    func numberVerificationFailed(error: Error){}
    
    func operationSuccess(msg: String){}
    func operationFailed(error: Error){}
    
    func logoutSuccess(){}
}

