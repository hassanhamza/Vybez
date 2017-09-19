//
//  SubmitViewController.swift
//  Vybez
//
//  Created by Hassan on 6/25/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage
import MBProgressHUD

class SubmitViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var coverImage: UIButton!
    @IBOutlet weak var eventName: UIButton!
    @IBOutlet weak var eventnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phonenumberTextfield: UITextField!
    @IBOutlet weak var categoriesTextfield: UITextField!
    @IBOutlet weak var eventRegionTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var hoursTextfield: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextView!
    @IBOutlet var collectionTextField: [UITextField]!
    var picker:UIImagePickerController?=UIImagePickerController()
    var imageView: UIImageView!
    var param=[String:Any]()
    var lat = String()
    var long = String()
    var placeName = String()
    var countryName = String()
    var streetAddress = String()
    var cityName = String()
    var zipCode = String()
    var placeFlag = Int()
    var mapEvent = String()
    var eventCategories = ["Live Shows","Night Life","Party","Lounges","Networking","Arts & Entertainment","Miscellaneous"]
//    var parameter = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationItem.setHidesBackButton(false, animated:true);
        picker!.delegate = self
        
        print("lat:\(lat)")
        print("long:\(long)")
        print("place:\(placeName)")
        datePicker.backgroundColor = UIColor.white
        viewPicker.isHidden = true
        
        pickerToolbar()
        
        eventName.titleLabel?.adjustsFontSizeToFitWidth = true
        eventName.titleLabel?.minimumScaleFactor = 0.2;
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (placeFlag == 1){
            locationName()
        }
        
        if (mapEvent.isEmpty) {
        }else{
            eventnameTextfield.text = mapEvent
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
    
    
    func locationName(){
        
        var param = [String:Any]()
        
        let geoCoder = CLGeocoder()
        var location = CLLocation()
        if (lat.isEmpty && long.isEmpty) {
            
            return showErrorAlert(message: "No Place Found. Select Location Again.")
        }else{
            print("lat:\(lat)")
            print("long:\(long)")
            param["latlng"] = "\(lat)" + "," + "\(long)"
            print(param)
            location = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
            print(location)
        }
        
        Webservice.sharedInstance.getPlaces(param: param, completion: {
        (SignInresult) -> Void in print((SignInresult[0]))
            var result = [String:Any]()
            result = SignInresult[0] as! [String : Any]
            if ((SignInresult[0] as AnyObject).count != nil){
                print(result["formatted_address"] ?? "Null")
                var address = String()
                address = result["formatted_address"] as! String
                if (address.isEmpty){
                    return self.showErrorAlert(message: "No Place Found. Select Location Again.")
                }else{
                    
                    self.placeName = address as String
                    self.eventName.setTitle(self.placeName, for: .normal)
                }
            }
            
            
        })
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary ?? "Place Mark not available.")
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                print(locationName)
//                self.placeName = locationName as String
//                self.eventName.setTitle(self.placeName, for: .normal)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
                self.streetAddress = street as String
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                print(city)
                self.cityName = city as String
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
                self.zipCode = zip as String
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print(country)
                self.countryName = country as String
            }
            
        })
        placeFlag = 0
    }

    
    func textFieldCheck(){
        for textField in collectionTextField {
            if (textField.text?.isEmpty ?? true){
                return showErrorAlert("Alert", message: "Text Field Empty", actions:nil)
            }
        }
    }
    
    func submitEvent(){
        
        if (eventnameTextfield.text?.isEmpty)! {
            param["eventName"] = "null"
        }else{
            
            param["eventName"] = eventnameTextfield.text
        }
        
        if (eventRegionTextfield.text?.isEmpty)! {
            param["eventRegion"] = "null"
        }else{
            param["eventRegion"] = eventRegionTextfield.text
        }
        
        if (lat.isEmpty && long.isEmpty) {
            param["eventLat"] = "null"
            param["eventLong"] = "null"
        }else{
            param["eventLat"] = lat
            param["eventLong"] = long
        }
        
        if(placeName.isEmpty){
            param["locationName"] = "null"
        }else{
            param["locationName"] = placeName
            param["location"] = placeName
        }
        
        if (categoriesTextfield.text?.isEmpty)! {
            
            param["categories"] = "null"
        }else{
            param["categories"] = categoriesTextfield.text
        }
        
        if (self.cityName.isEmpty) {
            param["cityAddress"] = "null"
        }else{
            param["cityAddress"] = self.cityName
        }
        
        if (self.streetAddress.isEmpty) {
            param["streetAddress"] = "null"
        }else{
            param["streetAddress"] = self.streetAddress
        }
        
        if (self.countryName.isEmpty) {
            param["countryName"] = "null"
        }else{
            param["countryName"] = self.countryName
        }
        
        if (self.zipCode.isEmpty) {
            param["zipCodes"] = "null"
        }else{
            param["zipCodes"] = self.zipCode
        }
        
        if (dateTextfield.text?.isEmpty)! {
            param["eventDate"] = "null"
        }else{
            param["eventDate"] = dateTextfield.text
        }
        
        if (hoursTextfield.text?.isEmpty)! {
            
            param["eventTime"] = "null"
        }else{
            param["eventTime"] = hoursTextfield.text
        }
        
        if (phonenumberTextfield.text?.isEmpty)! {
            
            param["phoneNumber"] = "null"
        }else{
            param["phoneNumber"] = phonenumberTextfield.text
        }
        
        if(Helper.isValidEmail(emailTextfield.text!)){
            param["email"] = emailTextfield.text
        }else{
            return showErrorAlert("Alert", message:"Invalid Email", actions: nil)
        }
        
        if (descriptionTextfield.text ?? "").isEmpty {
            param["description"] = "null"
        }else{
        param["description"] = descriptionTextfield.text
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionTextfield.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        for textField in collectionTextField {
            textField.resignFirstResponder()
            return true
        }
        return true
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
    
    @IBAction func eventLocationAction(_ sender: Any) {
        
        let viewController:MapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        if ((eventnameTextfield.text?.isEmpty)!) {
            
        }else{
            viewController.eventNameTextfield = eventnameTextfield.text!
        }
        self.navigationController?.pushViewController(viewController, animated: true)

    }

    @IBAction func submitAction(_ sender: Any) {
        
        if(Webservice.sharedInstance.isConnectedToInternet()){
            
            textFieldCheck()
            submitEvent()
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
            print(param)
            Webservice.sharedInstance.submitEvents(param: param, completion: {
                (SignInresult) -> Void in print(SignInresult)
                MBProgressHUD.hide(for: self.view, animated: true)
                if(SignInresult == "Event saved."){
                    return self.showErrorAlert(message: "Event Submitted Successfully.")
                }
            })

        }
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pickerToolbar(){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 150/255, green: 20/255, blue: 128/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateTextfield.inputView = datePicker
        datePicker.removeFromSuperview()
        dateTextfield.inputAccessoryView = toolBar
        
        hoursTextfield.inputView = datePicker
        datePicker.removeFromSuperview()
        hoursTextfield.inputAccessoryView = toolBar
        
        categoriesTextfield.inputView = pickerView
        pickerView.removeFromSuperview()
        categoriesTextfield.inputAccessoryView = toolBar
    }
    
    func donePicker (sender:UIBarButtonItem)
    {
        viewPicker.isHidden = true
        dateTextfield.resignFirstResponder()
        categoriesTextfield.resignFirstResponder()
        hoursTextfield.resignFirstResponder()
    }
    
}

extension SubmitViewController:UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate{
    
    
    @IBAction func libraryOrCamera(_ sender: Any) {
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
    
     public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
//        let imageURL = info[UIImagePickerControllerReferenceURL] as? NSURL
//        let imageName = imageURL?.lastPathComponent
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
//        let localPath = documentDirectory.appendingPathComponent(imageName)
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let data = UIImagePNGRepresentation(image)
//        data.writeToFile(localPath, atomically: true)
//        
//        let imageData = NSData(contentsOfFile: localPath)!
//        let photoURL = NSURL(fileURLWithPath: localPath)
//        let imageWithData = UIImage(data: imageData)!
        
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.image = image
//        }
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imagePath =  imageURL?.path
        print(imagePath ?? "no path")
        let fileName:NSString = imagePath! as NSString
        coverImage.setTitle(  fileName.lastPathComponent, for: .normal)
        
        let localPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imagePath!)
        
        //this block of code adds data to the above path
        let path = localPath?.relativePath
        let imageName = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImageJPEGRepresentation(imageName, 0.2)
        do{
            try data?.write(to: URL(fileURLWithPath: path!), options: .atomic)
        } catch{
            print(error);
        }
        //this block grabs the NSURL so you can use it in CKASSET
        let photoURL = NSURL(fileURLWithPath: path ?? "")
        print(photoURL)
        if (photoURL.absoluteString ?? "").isEmpty {
            param["userPhoto"] = "null"
        }else{
            param["userPhoto"] = photoURL.absoluteString
        }
        picker.dismiss(animated: true, completion: nil)
    }
    private func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
}

extension SubmitViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categoriesTextfield.text = eventCategories[row]
    }
}

extension SubmitViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if (textField == dateTextfield) {
            
            datePicker.datePickerMode = UIDatePickerMode.date
        }
        if (textField == hoursTextfield) {
            
            datePicker.datePickerMode = UIDatePickerMode.time
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if (textField == dateTextfield) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            print(selectedDate)
            dateTextfield.text = selectedDate
        }
        
        if (textField == hoursTextfield) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            print(selectedDate)
            hoursTextfield.text = selectedDate

        }
    }
}
