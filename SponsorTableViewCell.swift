//
//  SponsorTableViewCell.swift
//  Vybez
//
//  Created by Hassan on 8/19/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class SponsorTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var images = ["sponsor","sponsor","sponsor","sponsor","sponsor","sponsor","sponsor"]
    var url = ["https://www.dunkindonuts.com/en","https://www.dunkindonuts.com/en","https://developer.apple.com/","https://www.youtube.com/","https://www.baskinrobbins.com/content/baskinrobbins/en.html","https://www.haagendazs.us/"]
    var link = String()
    var scrollingTimer = Timer()
    var delegate:SelectionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.register(UINib (nibName:"SponsorViewCell" , bundle: nil), forCellWithReuseIdentifier: "SponsorViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SponsorTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsorViewCell", for: indexPath) as! SponsorViewCell
        var rowIndex = indexPath.row
                    let numberOfRows:Int = images.count - 1
                    if (rowIndex < numberOfRows) {
                        rowIndex = (rowIndex + 1)
                    }else{
                        rowIndex = 0
                    }
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
        return cell
    }
    
    func startTimer(theTimer:Timer){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations:{
            self.collectionView.scrollToItem(at: IndexPath(row:theTimer.userInfo! as! Int,section:0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:414,height:210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        link = url[indexPath.row]
        delegate?.didSelectRow(url: url[indexPath.row])
        print("Collection:",indexPath.row)
    }
}

