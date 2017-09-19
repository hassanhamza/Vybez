//
//  UserViewController.swift
//  Vybez
//
//  Created by Hassan on 6/7/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController{

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    var picker:UIImagePickerController?=UIImagePickerController()
    var tab = RaisedTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.clipsToBounds = true
        picker!.delegate = self
        
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey:"email") ?? "Vybez@mail.com"
        let name = userDefaults.string(forKey: "name") ?? "Vybez"
        
        usernameLabel.text = email
        userEmailLabel.text = name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaveReview(_ sender: Any) {
    }

    @IBAction func howItWorks(_ sender: Any) {
        
        let viewController:WebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.request = "https://vybezapp.com/how-it-works/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func termsOfServices(_ sender: Any) {
        let viewController:WebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.request = "https://vybezapp.com/terms-of-use/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func privacyPolicy(_ sender: Any) {
        let viewController:WebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.request = "https://vybezapp.com/privacy-policy/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func contactUs(_ sender: Any) {
        let viewController:WebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.request = "https://vybezapp.com/contact-us/"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
   
    @IBAction func imageAction(_ sender: Any) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
            
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            self.present(picker!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    
    func openGallary()
    {
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker!, animated: true, completion: nil)
    }

    @IBAction func logoutAction(_ sender: Any) {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func changePasswordAction(_ sender: Any) {
        
        let viewController:ResetPasswordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension UserViewController:UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let imageURL = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imagePath =  imageURL?.path
        let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath!)
        
        //this block of code adds data to the above path
        let path = localPath?.relativePath
        let imageName = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImagePNGRepresentation(imageName)
        if data != nil {
            userImageView.image = UIImage(data: data!)
        }
        do{
            try data?.write(to: URL(fileURLWithPath: path!), options: .atomic)
        } catch{
            print(error);
        }
        //this block grabs the NSURL so you can use it in CKASSET
        let photoURL = NSURL(fileURLWithPath: path ?? "")
        print(photoURL)
        if (photoURL.absoluteString ?? "").isEmpty {
//            param["userPhoto"] = "null"
        }else{
            let userDefaults = UserDefaults.standard
            userDefaults.set(photoURL.absoluteString, forKey: "userPhoto")
            userDefaults.synchronize()

//            param["userPhoto"] = photoURL.absoluteString
        }
        picker.dismiss(animated: true, completion: nil)
    }
    private func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }

}
