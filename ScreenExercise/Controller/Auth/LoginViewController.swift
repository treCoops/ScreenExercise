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
    var apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.isHidden = true
        loginButton.permissions = ["email"]
        
        apiHelper.delagate = self
        
        let user = Auth.auth().currentUser
        
        if user != nil{
            if !UserSession.exists(key: UserSessionKey.USER_LOGGED){
                if (UserSession.getUserDefaultBool(key: UserSessionKey.USER_LOGGED)!){
                    performSegue(withIdentifier: "SegueToHome", sender: self)
                }
            }
        }
        
//        apiHelper.createUser(name: "test", email: "trevogayan@gmail.com", phone: "0777123456", type: "1", comments: "This is test", provider: "Dialog")
//        apiHelper.getAllUsers()
//        apiHelper.updateUser(token: "4", name: "Somasiri", email: "somaa@gmail.com", phone: "0777777771", provider: "Verizon")
//        apiHelper.getUserDetails(token: "4")
//        apiHelper.getCategories()
//        apiHelper.getActivities()
        
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

extension LoginViewController: API {
    func response(status: Int, message: String){
        print("Response from create user : \(status) <> \(message)")
    }
    func response(status: Int, message: String, data: [User]){
        print("Response from create user : \(status) <> \(message)")
        print("Data : \(data)")
    }
    func response(status: Int, message: String, user: User){
        print(user.provider)
    }
    
    func error(error: Error){
        print("Response from error : \(error)")
    }
    
    func error(error: String){
        print("Response from error : \(error)")
    }
}

