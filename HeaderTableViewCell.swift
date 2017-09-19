//
//  HeaderTableViewCell.swift
//  Vybez
//
//  Created by Hassan on 8/19/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib (nibName:"HeaderViewCell" , bundle: nil), forCellWithReuseIdentifier: "HeaderViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: "HeaderTableViewCell")
//        self.collectionView.register(UINib (nibName:"HeaderViewCell" , bundle: nil), forCellWithReuseIdentifier: "HeaderViewCell")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    
}

extension HeaderTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderViewCell", for: indexPath) as! HeaderViewCell
//            return cell
//            var rowIndex = indexPath.row
//            let numberOfRows:Int = images.count - 1
//
//            if (rowIndex < numberOfRows) {
//                rowIndex = (rowIndex + 1)
//            }else{
//                rowIndex = 0
//            }

//            scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
            return cell
        }

//    func startTimer(theTimer:Timer){
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations:{
//            self.collectionView.scrollToItem(at: IndexPath(row:theTimer.userInfo! as! Int,section:2), at: .centeredHorizontally, animated: false)
//        }, completion: nil)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width:414,height:284)
    }
}

