//
//  DiscoveryViewController.swift
//  Vybez
//
//  Created by Hassan on 6/10/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import BBannerView

private enum Sections: Int {
    case header = 0
    case event = 1
    case sponsor = 2
}
class DiscoveryViewController: UIViewController {
    
    // MARK: @IBOutlets.
    
    @IBOutlet weak var tableView: UITableView!
    var images = ["sponsor","sponsor","sponsor","sponsor","sponsor"]
    var categories = ["DISCOVERY","POPULAR EVENTS","SPONSORED ADS"]
    var scrollingTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.collectionView.register(UINib (nibName:"HeaderViewCell" , bundle: nil), forCellWithReuseIdentifier: "HeaderViewCell")
//        self.collectionView.register(UINib (nibName:"EventViewCell" , bundle: nil), forCellWithReuseIdentifier: "EventViewCell")
//        self.collectionView.register(UINib (nibName:"SponsorViewCell" , bundle: nil), forCellWithReuseIdentifier: "SponsorViewCell")
        
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        tableView.register(UINib(nibName: "SponsorTableViewCell", bundle: nil), forCellReuseIdentifier: "SponsorTableViewCell")
        
            self.navigationController?.isNavigationBarHidden = true
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderViewCell", for: indexPath) as! HeaderViewCell
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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

}

//extension DiscoveryViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (section == 0 ) {
//            return 1
//        }else if (section == 1){
//            return 1
//        }else{
//            return images.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        switch indexPath.section{
//        case Sections.header.rawValue:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderViewCell", for: indexPath) as! HeaderViewCell
//            return cell
//        case Sections.event.rawValue:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventViewCell", for: indexPath) as! EventViewCell
//            return cell
//        case Sections.sponsor.rawValue:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsorViewCell", for: indexPath) as! SponsorViewCell
//            cell.sponsorImage.image = UIImage(named:images[indexPath.row])
//            var rowIndex = indexPath.row
//            let numberOfRows:Int = images.count - 1
//            
//            if (rowIndex < numberOfRows) {
//                rowIndex = (rowIndex + 1)
//            }else{
//                rowIndex = 0
//            }
//            
//            scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//    
//    func startTimer(theTimer:Timer){
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations:{
//            self.collectionView.scrollToItem(at: IndexPath(row:theTimer.userInfo! as! Int,section:2), at: .centeredHorizontally, animated: false)
//        }, completion: nil)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        switch indexPath.section {
//        case Sections.header.rawValue:
//            return CGSize(width:414,height:284)
//        case Sections.event.rawValue:
//            return CGSize(width:414,height:210)
//        case Sections.sponsor.rawValue:
//            return CGSize(width:414,height:150)
//        default:
//            return CGSize(width:414,height:150)
//        }
//    }
//}
//
//extension DiscoveryViewController:BBannerViewDelegate,BBannerViewDataSource{
//    
//    func numberOfItems() -> Int {
//        return images.count
//    }
//    
//    func viewForItem(bannerView: BBannerView, index: Int) -> UIView {
//        let imageView = UIImageView(frame: bannerView.bounds)
//        imageView.image = UIImage(named: images[index])
//        
//        return imageView
//    }
//    
//    // MARK: - BBannerViewDelegate
//    
//    func didSelectItem(index: Int) {
//        print("banner1 index: \(index)")
//    }
//
//}

extension DiscoveryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }else{
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
            tableView.rowHeight = 284
            return cell
        }else if (indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as! EventTableViewCell
            tableView.rowHeight = 210
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SponsorTableViewCell") as! SponsorTableViewCell
            cell.delegate = self
            tableView.rowHeight = 170
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Section \(indexPath.section), Row : \(indexPath.row)")
        if indexPath.section == 1 && indexPath.row == 0{
            //Code to implement View Controller to remove adds
            print("Remove Adds")
        }

    }

}

extension DiscoveryViewController:SelectionDelegate{
    func didSelectRow(url: String) {
        let viewController:WebViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        viewController.request = url
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}

