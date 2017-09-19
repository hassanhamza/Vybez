//
//  FavoriteViewController.swift
//  Vybez
//
//  Created by Hassan on 6/15/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class FavoriteViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var favoriteArray = [Favorites]()
    var favoriteTitle = String()
    var deleteFlag = Int()
    var updateFlag = Int()
    var isState = true
    var likeArray = [Favorites]()
    var slat = String()
    var slon = String()
    var distanceInMiles = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        print(self.navigationController!.viewControllers.count)
        
        let userDefaults = UserDefaults.standard
        updateFlag = userDefaults.integer(forKey: "updateFlag")
        favoriteTitle = userDefaults.string(forKey: "favoriteTitle") ?? ""
        
        slat = userDefaults.string(forKey: "sLat") ?? ""
        slon = userDefaults.string(forKey: "sLon") ?? ""
        
        print(updateFlag)
        print(favoriteTitle)
        
        if (updateFlag == 1) {
            favoriteEvent()
        }
        
        userImage.layer.cornerRadius = userImage.frame.width/2
        userImage.clipsToBounds = true
        
        let imageUrl = userDefaults.string(forKey: "userPhoto") ?? "null"
        
        if (imageUrl == "null") {
            
        }else{
            let url = URL(string: imageUrl)
            do {
                let imageData = try Data(contentsOf: url!)
                userImage.image = UIImage(data: imageData)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        let userDefaults = UserDefaults.standard
        updateFlag = userDefaults.integer(forKey:"updateFlag")
        favoriteTitle = userDefaults.string(forKey:"favoriteTitle") ?? ""
        
        slat = userDefaults.string(forKey: "sLat") ?? ""
        slon = userDefaults.string(forKey: "sLon") ?? ""

        if (updateFlag == 1) {
            favoriteEvent()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func favoriteEvent(){
        
        let realm = try! Realm()
        
        
        let allLike = realm.objects(Like.self)
        
        for like in allLike{
            
            print(like)
            let fav = Favorites(titleString:like.titleString, imageUrl:like.imageUrl, lat:like.lat, long:like.long, date:like.date)
            likeArray.append(fav)
        }
        print(likeArray)
        print(likeArray.count)
        
        try! realm.write {
            realm.deleteAll()
        }
        
        if (likeArray.count != 0) {
            
            for fav in likeArray{
                
                favoriteArray.append(fav)
            }
            
            print(favoriteArray)
            print(favoriteArray.count)
            
            likeArray.removeAll()
            tableView.reloadData()
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "updateFlag")
            userDefaults.synchronize()
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
    
    @IBAction func deleteAction(_ sender: Any) {
        isState = !isState
        if isState {
            deleteButton.setTitle("Delete", for: .normal)
            deleteFlag = 0
            tableView.isEditing = false
            tableView.reloadData()
        }else{
            deleteButton.setTitle("Done", for: .normal)
            deleteFlag = 1
            tableView.isEditing = true
            tableView.reloadData()


        }
    }
    
}

extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (favoriteArray.count == 0){
            return 1
        }else{
            return favoriteArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell") as! FavoriteViewCell
        
        if (favoriteArray.count == 0){
            cell.eventNameLabel.text = "No Favorite Event"
            cell.dateMilesLabel.text = ""
        }else{
            if (slat.isEmpty && slon.isEmpty) {}else{
                
                let lat = favoriteArray[indexPath.row].lat
                let lon = favoriteArray[indexPath.row].long
                
                let source = CLLocation(latitude:Double(slat)! , longitude:Double(slon)!)
                let dest = CLLocation(latitude:Double(lat)! , longitude:Double(lon)!)
                
                let distanceInMeters = source.distance(from: dest)
                let double = String((distanceInMeters/1609.344))
                print(distanceInMeters)
                print(distanceInMiles)
                print(String(format: "%.2f", double))
                distanceInMiles = String(format: "%.2f", double)
            }
            cell.eventNameLabel.text = favoriteArray[indexPath.row].titleString
            let date = favoriteArray [indexPath.row].date
            if (distanceInMiles.isEmpty) {
                
                let dateMile = date
                cell.dateMilesLabel.text = dateMile
            }else{
                let dateMile = date + " " + distanceInMiles + " miles"
                cell.dateMilesLabel.text = dateMile

            }
        }
        
        if(deleteFlag == 1){
            cell.likeImageView.isHidden = true
        }else{
            cell.likeImageView.isHidden = false
            cell.likeImageView.image = UIImage(named:"like")
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            favoriteArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

