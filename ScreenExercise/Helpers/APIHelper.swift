//
//  APIHelper.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-23.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class APIHelper{
    
    var delagate : API?
    let BaseURL : String = "https://screenexersice-api.herokuapp.com"
    
    func createUser(name: String, email: String, phone: String, type: String, comments: String, provider: String){
        let url = "\(BaseURL)/api/user/create"
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "type": type,
            "comments": comments,
            "provider": provider
        ]
         
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.delagate?.response(status: json["status"].int ?? 0, message: json["message"].string ?? "asd")

                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
    }
    
    func updateUser(token: String, name: String, email: String, phone: String, provider: String){
        let url = "\(BaseURL)/api/user/update"
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "provider": provider
        ]
        
        let headers: HTTPHeaders = [
            "token": token
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.delagate?.response(status: json["status"].int ?? 0, message: json["message"].string ?? "asd")

                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
    }
    
    func getAllUsers(){
        let url = "\(BaseURL)/api/user/all"
        var users : [User] = []
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        if let body = json["body"].arrayObject{
                            for user in body {
                                guard let innerDict = user as? [String: Any] else {
                                    continue
                                }
                                
                                users.append(User(provider: innerDict["provider"] as! String, phone: innerDict["phone"] as! String, updatedAt: innerDict["updatedAt"] as! String, status: innerDict["status"] as! Int, type: innerDict["type"] as! Int, token: "Token not available", name: innerDict["name"] as! String, email: innerDict["email"] as! String, id: innerDict["id"] as! Int, comments: innerDict["comments"] as! String, joinDate: innerDict["joinDate"] as! String))
                            }

                            self.delagate?.response(status: json["status"].int ?? 0, message: json["message"].string ?? "no message found", data: users)
                        }
                        
                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
    }
    
    func getUserDetails(token: String){
        let url = "\(BaseURL)/api/user/profile"
        
        let headers: HTTPHeaders = [
            "token": token
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let obj = json["body"].dictionaryObject
                        if(obj != nil){
                            let userProfile : User = User(provider: obj!["provider"] as? String ?? "", phone: obj!["phone"] as? String ?? "", updatedAt: obj!["updatedAt"] as? String ?? "", status: obj!["status"] as? Int ?? 1, type: obj!["type"] as? Int ?? 1, token: obj!["token"] as? String ?? "", name: obj!["name"] as? String ?? "", email: obj!["email"] as? String ?? "", id: obj!["id"] as? Int ?? 1, comments: obj!["comments"] as? String ?? "", joinDate: obj!["joinDate"] as? String ?? "")
                            
                            self.delagate?.response(status: json["status"].int ?? 0, message: json["message"].string ?? "no message found", user: userProfile)
                        }else{
                            self.delagate?.error(error: "No user profile exists")
                        }
                    
                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
    }
    
    func getCategories(){
        
        let url = "\(BaseURL)/api/category/all"
        
        var categoryCount : Int = 0
        var activityCount : Int = 0
        var activityLoadingCount = 0
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.clearTableCategory()
                        self.clearTableActivity()
                        if let body = json["body"].arrayObject{
                            categoryCount = body.count
                            for cate in body {
                                guard let innerDict = cate as? [String: Any] else {
                                    continue
                                }
                                let category = Category()
                                category.id = innerDict["id"] as! Int
                                category.name = innerDict["name"] as! String
//                                category.comments = innerDict["comments"] as! String
                                category.image = innerDict["image"] as! String
                                category.type = innerDict["type"] as! Int
                                
                                let realm = try! Realm()
                                try! realm.write{
                                    realm.add(category)
                                    print("Category cached success!")
                                }
                                
                                let activities = JSON(innerDict["activities"]!)
                                
                                if let act = activities.arrayObject{
                                    activityCount = activityCount + act.count
                                    for activity in act {
                                        guard let innerDict = activity as? [String: Any] else {
                                            continue
                                        }
                                        DispatchQueue.main.async{
                                            
                                            let destination: DownloadRequest.Destination = { _, _ in
                                                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                                let fileURL = documentsURL.appendingPathComponent("ScreenExercise/\(self.getLottieName(url: innerDict["link"] as! String))")

                                                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                                            }
                                            
                                            
                                            AF.download(innerDict["link"] as! String, to: destination).response { response in
                                                if response.error == nil, let jsonPath = response.fileURL?.path {

                                                    let activity = Activity()
                                                    activity.category_id = innerDict["category_id"] as! Int
//                                                    activity.des = innerDict["description"] as! String
                                                    activity.fileName = self.getLottieName(url: innerDict["link"] as! String)
                                                    activity.filePath = jsonPath
                                                    activity.id = innerDict["id"] as! Int
                                                    activity.link = innerDict["link"] as! String
                                                    activity.name = innerDict["name"] as! String
//                                                    activity.status = innerDict["status"] as! Int
//                                                    activity.used_count = innerDict["used_count"] as! Int

                                                    try! realm.write{
                                                        realm.add(activity)
                                                        print("Activity cached success!")
                                                        activityLoadingCount = activityLoadingCount + 1
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            
                            self.delagate?.refreshStatus(categoryCount: categoryCount, activityCount: activityCount, activityLoadingCount: activityLoadingCount)
                            
                        }
                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
        
        

    }
    
    func getLottieName(url: String) -> String{
        let text = url.split(separator: "/")
        return String(text[text.count-1])
    }
    
    func clearTableCategory(){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(Category.self))
        }
    }
    
    
    func clearTableActivity(){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(Activity.self))
        }
    }
}

protocol API {
    func response(status: Int, message: String)
    func response(status: Int, message: String, data: [User])
    func response(status: Int, message: String, user: User)
    func error(error: Error)
    func error(error: String)
    func refreshStatus(categoryCount: Int, activityCount: Int, activityLoadingCount: Int)
    
}

extension API {
    func response(status: Int, message: String){}
    func response(status: Int, message: String, data: [User]){}
    func response(status: Int, message: String, user: User){}
    func error(error: Error){}
    func error(error: String){}
    func refreshStatus(categoryCount: Int, activityCount: Int, activityLoadingCount: Int){}
}
