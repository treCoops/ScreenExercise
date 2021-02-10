//
//  ViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin



class LoginViewController: UIViewController {
    
    var loginButton : FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.isHidden = true
        loginButton.permissions = ["email"]
        
    }
    
    @IBAction func btnLoginFacebookPressed(_ sender: UIButton) {
        loginButton.sendActions(for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnGoogleLoginPressed(_ sender: UIButton) {
    
        GIDSignIn.sharedInstance().signOut()
        let sighIn:GIDSignIn = GIDSignIn.sharedInstance()
        sighIn.delegate = self;
        sighIn.signIn()
    }
}

extension LoginViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            AlertBar.danger(title: error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                AlertBar.danger(title: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "segueToSignInForm", sender: LoginViewController.self)
            }
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
            
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "gh")
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print(error.localizedDescription)
            return
          }
            self.performSegue(withIdentifier: "segueToSignInForm", sender: LoginViewController.self)
        }

    }
    
    
}

