//
//  Models.swift
//  AppStore
//
//  Created by afbdev on 1/17/17.
//  Copyright © 2017 afbdev. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json as! [String: AnyObject])
                
                
//                var appCategories = [AppCategory]()
//                
//                for dict in json["categories"] as! [[String: AnyObject]] {
//                    let appCategory = AppCategory()
//                    appCategory.setValuesForKeys(dict)
//                    appCategories.append(appCategory)
//                    
//                }
                
                DispatchQueue.main.async {
                    completionHandler(featuredApps)
                }
                
                
            } catch let err {
                print(err)
            }
            
        }.resume()
    }
    
//    static func sampleAppCategories() -> [AppCategory] {
//        
//        let bestNewAppsCategory = AppCategory()
//        bestNewAppsCategory.name = "Best New Apps"
//        
//        var apps = [App]()
//        
//        let frozenApp = App()
//        frozenApp.name = "Disney Build It: Frozen"
//        frozenApp.imageName = "frozen"
//        frozenApp.price = NSNumber(floatLiteral: 3.99)
//        apps.append(frozenApp)
//        
//        bestNewAppsCategory.apps = apps
//        
//        
//        
//        let bestNewGamesCategory = AppCategory()
//        bestNewGamesCategory.name = "Best New Games"
//        
//        var bestNewGamesApps = [App]()
//        
//        let telepaintApp = App()
//        telepaintApp.name = "Telepaint"
//        telepaintApp.category = "Games"
//        telepaintApp.imageName = "telepaint"
//        telepaintApp.price = NSNumber(floatLiteral: 2.99)
//        
//        bestNewGamesApps.append(telepaintApp)
//        bestNewGamesCategory.apps = bestNewGamesApps
//        
//        
//        
//        return [bestNewAppsCategory, bestNewGamesCategory]
//    }
}


class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
}
