//
//  DetailDiscoveryViewController.swift
//  Vybez
//
//  Created by Hassan on 6/21/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailDiscoveryViewController: UIViewController {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var DetailTextview: UITextView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var page:String = ""
    var pages:String = ""
    var titleString:String = ""
    var eventName:String = ""
    var eventsArray = [Events]()
    var searchArray = [Events]()
    var pagesCount=NSNumber()
    var isSreach:Bool = false
    var count:Int = 1
    var titleNav = String()
    var favTitle = String()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
//        tableView.refreshControl = refreshControl
        //        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        titleButton.setTitle(titleNav,for: .normal)
        titleButton.titleLabel!.numberOfLines = 0
        titleButton.titleLabel!.adjustsFontSizeToFitWidth = true
        titleButton.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        //        let image = UIImage(named:"header")
        //        UINavigationBar.appearance().setBackgroundImage(image?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        //
        //        let button = UIButton.init(type: .custom)
        //        button.setImage(UIImage.init(named: "back"), for: UIControlState.normal)
        //        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 17)
        //        let barButton = UIBarButtonItem.init(customView: button)
        //        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func getData(){
    
        var parameter = [String:Any]()
        
        if (page.isEmpty) {
            page = "1"
            parameter=["page":page]
            pagesCount = 0
        }
        
        var array = Array<Any>()
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        Webservice.sharedInstance.getData(param:parameter,completion:{
            (SignInresult,pages) -> Void in
            array = (SignInresult["docs"] as? [[String:Any]])!
            self.pages = pages
            print(pages)
            print(array)
            if let array = SignInresult["docs"] as? [[String:Any]] {
                let tempArray = Events.getEvents(param: array)
                if (self.pages >= self.page ){
                    self.count = self.count + 1
                    self.page = String(self.count)
                    parameter = ["page":self.page]
                    for eventt in tempArray {
                        //print(eventt)
                        self.eventsArray.append(eventt)
                    }

                }
                self.tableView.reloadData()
            }
//            self.pagesCount = SignInresult["pages"] as! NSNumber
//            print("pages:",self.pagesCount)
            MBProgressHUD.hide(for: self.view, animated: true)
            
        })
        
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

extension DetailDiscoveryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSreach && searchArray.count != 0) {
            return searchArray.count
        }else{
            print(eventsArray.count)
            return eventsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDiscoverViewCell") as! DetailDiscoverViewCell
        if (isSreach && searchArray.count != 0) {
            
            let eventDetail = (searchArray[indexPath.row]).eventName
            eventName = (searchArray[indexPath.row]).eventName
            let imageUrl = (searchArray[indexPath.row]).coverImageUrl
            let locationName = (searchArray[indexPath.row]).locationName
            print(eventDetail)
            print(eventName)
            print(locationName)
            print(imageUrl ?? "Value not found.")
            favTitle = eventName
            titleString = "\(eventName)"+"\n"+"\(locationName)"
            cell.detailTextView.text = titleString
            
            if (imageUrl != nil) {
                cell.detailImage.sd_setImage(with: URL(string:imageUrl!), placeholderImage:UIImage(named: "nightLife"))
            }else{
                cell.detailImage.image = UIImage(named: "nightLife")
            }
        }else{
            
            let eventDetail = (eventsArray[indexPath.row]).eventName
            eventName = (eventsArray[indexPath.row]).eventName
            var imagePath = (eventsArray[indexPath.row]).coverImageUrl
            favTitle = eventName
            print(imagePath!)
            let imageUrl = "http://104.131.162.230:3000" + imagePath!
            print(imageUrl)
            let locationName = (eventsArray[indexPath.row]).locationName
            //        print(eventDetail)
            //        print(eventName)
            //        print(locationName)
            //        print(imageUrl ?? "Value not found.")
            titleString = "\(eventName)"+"\n"+"\(locationName)"
            
            cell.detailTextView.text = titleString
            if (imageUrl.isEmpty) {
                cell.detailImage.image = UIImage(named: "nightLife")
            }else{
                cell.detailImage.sd_setImage(with: URL(string:imageUrl), placeholderImage:UIImage(named: "nightLife"))
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController:EventDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailController") as! EventDetailController
        if (isSreach && searchArray.count != 0) {
            let imageUrl = (searchArray[indexPath.row]).coverImageUrl
            let lat = (searchArray[indexPath.row]).eventLat
            let long = (searchArray[indexPath.row]).eventLong
            let date = (searchArray[indexPath.row]).eventDate
            viewController.imageUrl = imageUrl!
            viewController.titleString = favTitle
            viewController.lat = lat
            viewController.long = long
            viewController.eventName = eventName
            viewController.date = date
        }else{
            
            let imageUrl = (eventsArray[indexPath.row]).coverImageUrl
            let lat = (eventsArray[indexPath.row]).eventLat
            let long = (eventsArray[indexPath.row]).eventLong
            let date = (eventsArray[indexPath.row]).eventDate
            viewController.imageUrl = imageUrl!
            viewController.titleString = favTitle
            viewController.lat = lat
            viewController.long = long
            viewController.eventName = eventName
            viewController.date = date
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (isSreach && searchArray.count != 0) {
            
        }else{
            
            let lastElement = eventsArray.count - 1
            if (indexPath.row == lastElement) {
                if (pages > page) {
                    getData()
                }else{
                }
            }
        }
    }
}

extension DetailDiscoveryViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchArray = eventsArray.filter {
            
            var searchMatches = $0.locationName.contains(searchText)
            if let city = $0.cityAddress {
                isSreach = true
                searchMatches = searchMatches || city.contains(searchText)
            }
            
            if let address = $0.streetAddress {
                isSreach = true
                searchMatches = searchMatches || address.contains(searchText)
            }
            
            if let country = $0.countryName{
                isSreach = true
                searchMatches = searchMatches || country.contains(searchText)
            }
            
            
            if let zip = $0.zipCodes{
                isSreach = true
                searchMatches = searchMatches || zip.contains(searchText)
            }
            
            return searchMatches
        }
        
        if (searchBar.text?.isEmpty == true) {
            isSreach = false
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSreach = false
        tableView.reloadData()
    }
}

