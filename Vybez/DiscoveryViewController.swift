//
//  DiscoveryViewController.swift
//  Vybez
//
//  Created by Hassan on 6/10/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

private enum Sections: Int {
    case header = 0
    case event = 1
    case sponsor = 2
}
class DiscoveryViewController: UIViewController {
    
    // MARK: @IBOutlets.
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collectionView.register(UINib (nibName:"HeaderViewCell" , bundle: nil), forCellWithReuseIdentifier: "HeaderViewCell")
        self.collectionView.register(UINib (nibName:"EventViewCell" , bundle: nil), forCellWithReuseIdentifier: "EventViewCell")
        self.collectionView.register(UINib (nibName:"SponsorViewCell" , bundle: nil), forCellWithReuseIdentifier: "SponsorViewCell")
        
        self.navigationController?.isNavigationBarHidden = true
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

extension DiscoveryViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case Sections.header.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderViewCell", for: indexPath) as! HeaderViewCell
            return cell
        case Sections.event.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventViewCell", for: indexPath) as! EventViewCell
            return cell
        case Sections.sponsor.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsorViewCell", for: indexPath) as! SponsorViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case Sections.header.rawValue:
            return CGSize(width:414,height:284)
        case Sections.event.rawValue:
            return CGSize(width:414,height:210)
        case Sections.sponsor.rawValue:
            return CGSize(width:414,height:150)
        default:
            return CGSize(width:414,height:150)
        }
    }
}
