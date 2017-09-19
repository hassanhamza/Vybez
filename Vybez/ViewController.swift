//
//  ViewController.swift
//  Vybez
//
//  Created by Hassan on 7/22/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import GoogleSignIn
import MBProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet var collectionField: [UITextField]!
    var param=[String:Any]()
    var tab = RaisedTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldCheck(){
        for textField in collectionField {
            if (textField.text?.isEmpty ?? true){
                return showErrorAlert("Alert", message: "Text Field Empty", actions:nil)
            }
        }
    }
    
    func submitSignup(){
        
        textFieldCheck()
        if(Helper.isValidEmail(emailTextfield.text!)){
            param["email"] = emailTextfield.text!
        }else{
            return showErrorAlert("Alert", message:"Invalid Email", actions: nil)
        }
        
        let passwordLength = passwordTextfield.text?.characters.count
        if (passwordLength! < 6) {
            return showErrorAlert("Alert", message:"Password should consist minimum 6 characters", actions: nil)
        }else{
            if (passwordTextfield.text! == confirmPasswordTextfield.text!) {
                
                param["password"] = passwordTextfield.text
            }else{
                return showErrorAlert("Alert", message:"Password do not Match..", actions: nil)
            }
        }
        param["name"] = nameTextfield.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        for textField in collectionField {
            textField.resignFirstResponder()
            return true
        }
        return true
    }
    
    @IBAction func signinAction(_ sender: Any) {
        
        submitSignup()
        print("Param\(param)")
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        Webservice.sharedInstance.Signup(param: param, completion:{(Signupresult) -> Void in
            
            if(Signupresult.isEqual("Signup Successfully")){
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.emailTextfield.text, forKey: "email")
                userDefaults.set(self.nameTextfield.text, forKey: "name")
                userDefaults.synchronize()

                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                MBProgressHUD.hide(for: self.view, animated: true)
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                return self.showErrorAlert("Alert", message:"Signup Failed", actions: nil)
            }
        })
    }
}

extension SigninViewController: GIDSignInDelegate,GIDSignInUIDelegate{
    
    func googleSignIn() {
        
        Webservice.sharedInstance.googleSignIn(param: param, completion: {
            
            (signIn) in print(signIn)
            if(signIn.isEqual("Signup Successfully.")){
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                self.navigationController?.pushViewController(viewController, animated: true)
            }else if(signIn.isEqual("Email already exists.")){
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                MBProgressHUD.hide(for: self.view, animated: true)
            }else{
                return self.showErrorAlert("Alert", message: "Google Signin Failed.", actions:nil)
            }
        })
    }

    
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            
            if let userId = (user?.userID){
                print("\(userId)")
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            if let idToken = (user.authentication?.idToken){
                print("\(idToken)")
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            if let fullName = (user.profile.name){
                print("\(fullName)")
                param["profileName"] = fullName
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            if let givenName = (user.profile.givenName){
                print("\(givenName)")
                 param["profileGivenName"] = givenName
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            if let familyName = (user.profile.familyName){
                print("\(familyName)")
                 param["profileFamilyName"] = familyName
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            if let email = (user.profile.email){
                print("\(email)")
                 param["email"] = email
            }else{
                print("Couldn't assign value to user because it's nil")
            }
            
            googleSignIn()
        } else {
            print("\(error.localizedDescription)")
        }
    }
}

extension SigninViewController: FBSDKLoginButtonDelegate{
    
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//    print("User Logged In")
//    if ((error) != nil)
//    {
//    // Process error
//    }
//    else if result.isCancelled {
//    // Handle cancellations
//    }
//    else {
//    // If you ask for multiple permissions at once, you
//    // should check if specific permissions missing
//    if result.grantedPermissions.contains("email")
//    {
//    // Do work
//    }
//        }
//    }
    
     func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if ((error) != nil){
            
            print(error)
        }
            else if result.isCancelled {
            // Handle cancellations
            }
            else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email"){
                self .getFBUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result as Any)
                }
            })
        }
    }

}

