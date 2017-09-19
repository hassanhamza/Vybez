//
//  ResetPasswordViewController.swift
//  Vybez
//
//  Created by Hassan on 9/17/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import MBProgressHUD

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextfield: UITextField!
    var param=[String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func checkEmpty(){
        if (emailTextField.text?.isEmpty)! {
            return showErrorAlert("Alert", message: "Enter Email.", actions:nil)
        }
        if (passwordTextField.text?.isEmpty)! {
            return showErrorAlert("Alert", message:"Enter Password", actions:nil)
        }
        
        if (confirmTextfield.text?.isEmpty)! {
            return showErrorAlert("Alert", message:"Enter Password", actions:nil)
        }
    }

    
    @IBAction func submitAction(_ sender: Any) {
        
        checkEmpty()
        
        if(Helper.isValidEmail(emailTextField.text!)){
            param["email"] = emailTextField.text!
        }else{
            return showErrorAlert("Alert", message:"Invalid Email", actions: nil)
        }
        
        let passwordLength = passwordTextField.text?.characters.count
        if (passwordLength! < 6) {
            return showErrorAlert("Alert", message:"Password should consist minimum 6 characters", actions: nil)
        }else{
            if (passwordTextField.text! == confirmTextfield.text!) {
                
                param["password"] = passwordTextField.text
            }else{
                return showErrorAlert("Alert", message:"Password do not Match..", actions: nil)
            }
        }
        
        Webservice.sharedInstance.resetPassword(param: param, completion: { (SignInresult) -> Void in
            
            
            if(SignInresult.isEqual("Password updated Successfully.")){
                
                MBProgressHUD.hide(for: self.view, animated: true)
                return self.showErrorAlert("Alert", message:"Password is reset.", actions: nil)
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                return self.showErrorAlert("Alert", message:"Reset Password Failed.", actions: nil)
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmTextfield.resignFirstResponder()
        return true
    }
    

}
