//
//  Events.swift
//  Vybez
//
//  Created by Hassan on 8/3/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class Events: NSObject {
    let eventName:String
    let locationName:String
    let email:String
    let phoneNumber:String
    let categories:String
    let eventRegion:String
    let eventLat:String
    let eventLong:String
    let eventDate:String
    let eventTime:String
    let streetAddress:String?
    let cityAddress:String?
    let countryName:String?
    let zipCodes:String?
    let coverImageUrl:String?
    let coverImageName:String?
    let coverImageType:String?
    let eventDescription:String?
    
    init(eventName: String, locationName: String,email: String, phoneNumber: String, categories: String, eventRegion: String, eventLat: String, eventLong: String, eventDate:String, eventTime:String, streetAddress: String?, cityAddress: String?, countryName:String?, zipCodes: String?, coverImageUrl: String?, coverImageName: String?,coverImageType: String?,eventDescription: String?) {
        
        self.eventName = eventName
        self.locationName = locationName
        self.email = email
        self.phoneNumber = phoneNumber
        self.categories = categories
        self.eventRegion = eventRegion
        self.eventLat = eventLat
        self.eventLong = eventLong
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.streetAddress = streetAddress
        self.cityAddress = cityAddress
        self.countryName = countryName
        self.zipCodes = zipCodes
        self.coverImageUrl = coverImageUrl
        self.coverImageName = coverImageName
        self.coverImageType = coverImageType
        self.eventDescription = eventDescription
     }
    
    public static func getEvents(param:[[String:Any]]) -> [Events] {
        
        var eventsArray = [Events]()
        
        for events in param {
            if let eventName = events["eventName"] as? String,let locationName = events["locationName"] as? String, let email = events["email"] as? String,let phoneNumber = events["phoneNumber"] as? String, let categories = events["categories"] as? String, let eventRegion = events["eventRegion"] as? String, let eventLat = events["eventLat"] as? String, let eventLong = events["eventLong"] as? String, let eventDate = events["eventDate"] as? String, let eventTime = events["eventTime"] as? String, let streetAddress = events["streetAddress"] as? String, let cityAddress = events["cityAddress"] as? String, let countryName = events["countryName"] as? String, let zipCodes = events["zipCodes"] as? String {
                
                let coverImageUrl = events["coverImageUrl"] as? String
                let coverImageName = events["coverImageName"] as? String
                let coverImageType = events["coverImageType"] as? String
                let eventDescription = events["description"] as? String
                
                let event = Events(eventName: eventName, locationName: locationName, email: email, phoneNumber: phoneNumber, categories: categories, eventRegion: eventRegion, eventLat: eventLat, eventLong: eventLong,eventDate:eventDate, eventTime:eventTime, streetAddress:streetAddress, cityAddress: cityAddress, countryName:countryName, zipCodes:zipCodes, coverImageUrl: coverImageUrl, coverImageName: coverImageName, coverImageType: coverImageType, eventDescription: eventDescription)
                
                eventsArray.append(event)
            }
        }
        
        return eventsArray
    }
}
