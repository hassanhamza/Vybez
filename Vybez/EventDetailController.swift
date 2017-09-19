//
//  EventDetailController.swift
//  Vybez
//
//  Created by Hassan on 7/4/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UberRides
import LyftSDK
import RealmSwift

class EventDetailController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var lyftButton: LyftButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    let manager = CLLocationManager()
    var titleString:String = ""
    var imageUrl:String = ""
    var lat:String = ""
    var long:String = ""
    var eventName = ""
    var date = ""
    var favArray = Array<Any>()
    var favorite = [Favorites]()
    
    @IBOutlet weak var like: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let button = RideRequestButton()
        button.frame = CGRect(origin: CGPoint(x: 0,y :410), size: CGSize(width:227, height: button.frame.size.height))
        view.addSubview(button)
        
        lyftButton.deepLinkBehavior = LyftDeepLinkBehavior.web
        lyftButton.style = .multicolor
        
        let imagePath = "http://104.131.162.230:3000" + imageUrl
        eventImage.sd_setImage(with: URL(string:imagePath), placeholderImage:UIImage(named: "nightLife"))
        detailTextView.text = titleString
        
        print(titleString)
        print(imageUrl)
        print(lat)
        print(long)
        print(date)
        
        print(self.navigationController!.viewControllers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func likeButton(_ sender: Any) {
        
        like.setImage(UIImage(named: "like"), for: .normal)
        
        let mylike = Like()
        mylike.titleString = titleString
        mylike.imageUrl = imageUrl
        mylike.lat = lat
        mylike.long = long
        mylike.date = date
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(mylike)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(1, forKey: "updateFlag")
        userDefaults.synchronize()

    }
    
    func saveData(){
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: favArray)
        let userDefaults = UserDefaults.standard
        userDefaults.set(1, forKey: "updateFlag")
        userDefaults.set(encodedData, forKey: "Key")
        userDefaults.synchronize()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EventDetailController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(lat)!,Double(long)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        
        self.mapView.showsUserLocation = true
        
//        let annotation = MKPointAnnotation()
//        
//        annotation.coordinate = myLocation
//        annotation.title = "MY SHOP"
//        annotation.subtitle = "COME VISIT ME HERE!"
//        mapView.addAnnotation(annotation)
        print("Lat:\(location.coordinate.latitude)")
        print("Lat:\(location.coordinate.longitude)")

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pinLocation")
        }
        
        return annotationView
    }
}
