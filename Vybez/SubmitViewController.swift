//
//  SubmitViewController.swift
//  Vybez
//
//  Created by Hassan on 6/25/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var eventnameTextfield: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phonenumberTextfield: UITextField!
    @IBOutlet weak var liveshowsTextfield: UITextField!
    @IBOutlet weak var eventRegionTextfield: UITextField!
    @IBOutlet weak var coverImageTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var hoursTextfield: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionTextfield.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        eventnameTextfield.resignFirstResponder()
        locationField.resignFirstResponder()
        emailTextfield.resignFirstResponder()
        phonenumberTextfield.resignFirstResponder()
        liveshowsTextfield.resignFirstResponder()
        eventRegionTextfield.resignFirstResponder()
        coverImageTextfield.resignFirstResponder()
        dateTextfield.resignFirstResponder()
        hoursTextfield.resignFirstResponder()
        descriptionTextfield.resignFirstResponder()
        return true
    }

}
