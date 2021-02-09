//
//  ViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().signIn()

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("dsd")
        
        if let error = error {
            print(error.localizedDescription)
            
            return
        }
        guard let auth = user.authentication else { return }
        
        print("Auth id \(auth.idToken)")
        
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                print("asd")
            } else {
                
                print("Login Successful.")
                print(authResult?.user.uid ?? "noo")
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("dsd")
    }

    
    @IBAction func btnLoginFacebookPressed(_ sender: UIButton) {
        AlertBar.success(title: "asd")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnGoogleLoginPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

