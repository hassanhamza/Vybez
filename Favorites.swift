//
//  Favorites.swift
//  Vybez
//
//  Created by Hassan on 9/14/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class Favorites: NSObject, NSCoding {
    
    let titleString:String
    let imageUrl:String
    let lat:String
    let long:String
    let date:String
    
    init(titleString:String, imageUrl:String, lat:String, long:String, date:String ) {
        
        self.titleString = titleString
        self.imageUrl = imageUrl
        self.lat = lat
        self.long = long
        self.date = date
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.titleString = aDecoder.decodeObject(forKey: "titleString") as! String
        self.imageUrl = aDecoder.decodeObject(forKey: "imageUrl") as! String
        self.lat = aDecoder.decodeObject(forKey: "lat") as! String
        self.long = aDecoder.decodeObject(forKey: "long") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(titleString, forKey: "titleString")
        coder.encode(imageUrl, forKey: "imageUrl")
        coder.encode(lat, forKey: "lat")
        coder.encode(long, forKey: "long")
        coder.encode(date, forKey: "date")
    }
    
//    public static func getFavorites(model:[[String:Any]]) -> [Favorites]{
//        
//         var favoriteArray = [Favorites]()
//        
//        for favorite in model {
//            
//            if let titleString = favorite["titleString"] as? String, let imageUrl = favorite["imageUrl"] as? String, let lat = favorite["lat"] as? String, let long = favorite["long"] as? String, let date = favorite["date"] as? String{
//                
//                let favorite = Favorites(titleString:titleString, imageUrl:imageUrl, lat:lat, long:long, date:date)
//                
//                favoriteArray.append(favorite)
//            }
//        }
//        
//        return favoriteArray
//    }
}
