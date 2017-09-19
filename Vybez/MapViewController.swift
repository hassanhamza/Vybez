//
//  MapViewController.swift
//  Vybez
//
//  Created by Hassan on 7/27/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    let manager = CLLocationManager()
    var lat = String()
    var lon = String()
    var slat = String()
    var slon = String()
    var placeName = String()
    var eventNameTextfield = String()
    fileprivate var searchController: UISearchController!
    fileprivate var localSearchRequest: MKLocalSearchRequest!
    fileprivate var localSearch: MKLocalSearch!
    fileprivate var localSearchResponse: MKLocalSearchResponse!
    fileprivate var annotation: MKAnnotation!
    fileprivate var isCurrentLocation: Bool = false
    var selectedAnnotation: MKPointAnnotation?
    var locationDegress = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(false, animated:true);
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation() // start location manager
            print(eventNameTextfield)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(false, animated:true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let viewController:SubmitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        viewController.lat = lat
        viewController.long = lon
        viewController.placeFlag = 1
        if(eventNameTextfield.isEmpty){}else{
                viewController.mapEvent = eventNameTextfield
        }
        if (slat.isEmpty && slon.isEmpty) {}else{
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(slat, forKey: "sLat")
            userDefaults.set(slon, forKey: "sLon")
            userDefaults.synchronize()
        }
        let nav = UINavigationController(rootViewController:viewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
        self.navigationController?.isNavigationBarHidden = false
         self.navigationItem.setHidesBackButton(false, animated:true);
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

extension MapViewController:CLLocationManagerDelegate,MKMapViewDelegate{
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }

        
//        print(location.altitude)
//        print(location.speed)
        
        self.mapView.showsUserLocation = true
        
//        print("lat:\(location.coordinate.latitude)")
//        print("lon:\(location.coordinate.longitude)")
        
        slat = String(location.coordinate.latitude)
        slon = String(location.coordinate.longitude)
        
//        if !isCurrentLocation {
//            lat = String(location.coordinate.latitude)
//            lon = String(location.coordinate.longitude)
//            return
//        }
//        
        isCurrentLocation = false
//        locationName()
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
            annotationView.isDraggable = true
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print(#function)
    }
//
//    // Called when the annotation was added
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView?.animatesDrop = true
//            pinView?.canShowCallout = true
//            pinView?.isDraggable = true
//            pinView?.pinColor = .purple
//            
//            let rightButton: AnyObject! = UIButton(type: UIButtonType.detailDisclosure)
//            pinView?.rightCalloutAccessoryView = rightButton as? UIView
//        }
//        else {
//            pinView?.annotation = annotation
//        }
//        
//        return pinView
//    }
// 
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
//        if newState == MKAnnotationViewDragState.ending {
//            let droppedAt = view.annotation?.coordinate
//            print(droppedAt ?? "coordicate is nil")
//        }
        
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            //New cordinates
            print(view.annotation?.coordinate ?? "null")
            view.dragState = .none
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
//    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
//        selectedAnnotation = view.annotation as? MKPointAnnotation
//    }
}

extension MapViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        manager.stopUpdatingLocation()
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { [weak self] (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil {
                return self!.showErrorAlert(message: "Place Not Found")
            }
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = searchBar.text
            print(searchBar.text!)
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self?.locationDegress = pointAnnotation.coordinate
            
            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
            self!.mapView.centerCoordinate = pointAnnotation.coordinate
            print(pointAnnotation.coordinate)
            self!.lat = String(pointAnnotation.coordinate.latitude)
            self!.lon = String(pointAnnotation.coordinate.longitude)
            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
        }
    }

}

//extension MapViewController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        (viewController as? SubmitViewController)?.lat = lat
//        (viewController as? SubmitViewController)?.long = lon
//        (viewController as? SubmitViewController)?.placeName = placeName
//    }
//}


