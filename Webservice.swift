//
//  Webservice.swift
//  Vybez
//
//  Created by Hassan on 7/25/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import Foundation
import Alamofire

class Webservice {
    class var sharedInstance: Webservice {
        struct Static {
            static let instance: Webservice! = Webservice()
        }
        return Static.instance
    }
    
    init() {
        print("Init the Singleton!")
    }
    
    func signIn(params:[String:Any],completion:@escaping (_ SignInresult:String) -> Void){
        
        let baseUrl = "http://104.131.162.230:3000/login"
        
        Alamofire.request(baseUrl,method:.post, parameters:params, encoding: JSONEncoding.default, headers: [:]).responseJSON{
            response in
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["message"] as! String)
                }
            case .failure(let error):
                print(error)
                completion(String(describing:error))
            }
        }
    }
    
    func Signup(param:[String:Any],completion:@escaping(_ Signupresult:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/signup"
        
        Alamofire.request(baseUrl, method:.post, parameters: param, encoding: URLEncoding.default, headers: [:]).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["message"] as! String)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getEvents(completion:@escaping(_ Signupresult:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/getEvents"
        
        Alamofire.request(baseUrl).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["message"] as! String)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func submitEvents(param:[String:Any],completion:@escaping(_ Signupresult:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/events"
        
        var imageData = Data()
        var imageUrl = String()
        var imageName =  String()
        var imageExt = String()
        
        if (param["userPhoto"] != nil){
            
            imageUrl = param["userPhoto"] as! String
            let imagePath = imageUrl.components(separatedBy:"/")
            print(imagePath)
            imageName = imagePath.last!
            imageExt = (imageName as NSString).pathExtension
            let url = NSURL(string:imageUrl)
            imageData = try!Data(contentsOf:url! as URL)
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if(param["userPhoto"] != nil){
                multipartFormData.append(imageData, withName: "userPhoto", fileName: imageName, mimeType: "image/jpeg")
            }
            for (key, value) in param {
                if(key == "userPhoto"){}else{
                print(key)
                print(value)
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to:baseUrl)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
//                upload.uploadProgress(closure: { (progress) in
//                    //Print progress
//                    print(progress)
//                })
                
                upload.responseJSON { response in
                    //print response.result
                    print("Validation Successful")
                    if let json = response.result.value as? [String:Any] {
                        print("JSON: \(json)") // serialized json response
                        completion(json["message"] as! String)
                    }

                }
                
            case .failure(let error):
                //print encodingError.description
                print(error)
            }
        }
    }
    
    func getData(param:[String:Any],completion:@escaping(_ Signupresult:[String:Any], _ pages:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/events/getPages"
        
//        let parameters:[String:Any] = ["page":"1"]
        
        Alamofire.request(baseUrl, method:.get, parameters: param, encoding: URLEncoding.default).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
//                    print("JSON: \(json)") // serialized json response
                    let pagesCount = json["pages"] as! NSNumber
//                    pageCount = json["page"] as! NSNumber
                    completion(json,String(describing: pagesCount))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPlaces(param:[String:Any],completion:@escaping(_ Signupresult:Array<Any>) -> Void) {
        
        let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=25.7948347004546,-80.20639975"
        
        Alamofire.request(baseUrl).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["results"] as! Array)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func googleSignIn(param:[String:Any],completion:@escaping(_ Signupresult:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/socialSignup/google"
        
        Alamofire.request(baseUrl, method:.post, parameters: param, encoding: URLEncoding.default, headers: [:]).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["message"] as! String)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func resetPassword(param:[String:Any],completion:@escaping(_ Signupresult:String) -> Void) {
        
        let baseUrl = "http://104.131.162.230:3000/resetPassword"
        
        Alamofire.request(baseUrl, method:.post, parameters: param, encoding: URLEncoding.default, headers: [:]).responseJSON{ response in
            
            print(response.request ?? "Request is null")  // original URL request
            print(response.response ?? "Response is null") // URL response
            print(response.data ?? "Data is Null")     // server data
            print(response.result)
            
            
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [String:Any] {
                    print("JSON: \(json)") // serialized json response
                    completion(json["message"] as! String)
                }
            case .failure(let error):
                print(error)
            }
        }
    }


    
//    func getEventss(completion:@escaping(_ Signupresult:String) -> Void) {
//        
//        let baseUrl = "http://13.58.181.215:8080/events/getPages"
//        
//        var page:String = ""
//        var pages:String = ""
//        
//        let parameters = [String:Any]()
//        
//        if (page != nil) {
//            if (pages < page) {
//                var count:Int = Int(page)!
//                print(count)
//                count += 1
//            }
//            if (pages == page) {
//            
//            }
//        }else{
//            
//        }
//
//        
//        Alamofire.request(baseUrl).responseJSON{ response in
//            
//            print(response.request ?? "Request is null")  // original URL request
//            print(response.response ?? "Response is null") // URL response
//            print(response.data ?? "Data is Null")     // server data
//            print(response.result)
//            
//            
//            switch response.result {
//            case .success:
//                print("Validation Successful")
//                if let json = response.result.value as? [String:Any] {
//                    print("JSON: \(json)") // serialized json response
//                    completion(json["message"] as! String)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

    
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
