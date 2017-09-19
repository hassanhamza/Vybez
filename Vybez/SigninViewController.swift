//
//  SigninViewController.swift
//  Vybez
//
//  Created by Hassan on 6/5/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import GoogleSignIn
import MBProgressHUD

class SigninViewController: UIViewController{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var param = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
//        emailTextField.text = "hassan@app.com"
//        passwordTextfield.text = "qwerty1"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkEmpty(){
        if (emailTextField.text?.isEmpty)! {
            return showErrorAlert("Alert", message: "Enter Email.", actions:nil)
        }
        if (passwordTextfield.text?.isEmpty)! {
            return showErrorAlert("Alert", message:"Enter Password", actions:nil)
        }
    }
    
    func getParam(){
        checkEmpty()
        if (Helper.isValidEmail(emailTextField.text!)) {
            param["email"] = emailTextField.text!
        }else{
            return showErrorAlert("Alert", message:"Email is Inavlid", actions: nil)
        }
        
        let passwordLength = passwordTextfield.text?.characters.count
        if (passwordLength! < 6) {
            return showErrorAlert("Alert", message:"Password should consist minimum 6 characters", actions: nil)
        }else{
            param["password"] = passwordTextfield.text
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logininAction(_ sender: Any) {
        
        if (emailTextField.text?.isEmpty)! {
            return showErrorAlert(message: "Enter Email.")
        }else{
            if (Helper.isValidEmail(emailTextField.text!)) {
                param["email"] = emailTextField.text!
            }else{
                return showErrorAlert("Alert", message:"Email is Inavlid", actions: nil)
            }
        }
        
        if (passwordTextfield.text?.isEmpty)! {
            return showErrorAlert("Alert", message:"Enter Password", actions:nil)
        }else{
            let passwordLength = passwordTextfield.text?.characters.count
            if (passwordLength! < 6) {
                return showErrorAlert("Alert", message:"Password should consist minimum 6 characters", actions: nil)
            }else{
                param["password"] = passwordTextfield.text!
            }
        }

        let email:String = param["email"] as? String ?? "Null"
        let password:String = param["password"] as! String
        
        if (email.isEmpty && password.isEmpty){
            
        }else{
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"

            Webservice.sharedInstance.signIn(params: param, completion:{(SignInresult) -> Void in
                
                if(SignInresult.isEqual("User authenticate Sucessfully.")){
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                return self.showErrorAlert("Alert", message:"Login Failed", actions: nil)
            }
            })
        }
    }

    @IBAction func signupAction(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        emailTextField.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        return true
    }
}
