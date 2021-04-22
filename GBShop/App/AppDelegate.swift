//
//  AppDelegate.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 04.04.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let requestFactory = RequestFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let auth = requestFactory.makeAuthRequestFactory()
        let userData = requestFactory.makeUserDataRequestFactory()
        let productsData = requestFactory.makeProductsDataRequestFactory()
        let reviewsData = requestFactory.makeReviewsDataRequestFactory()
        
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.logout(idUser: 123) { response in
            switch response.result {
            case .success(let logout):
                print (logout)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
       
        userData.registration (idUser: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let registration):
                print (registration)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    
        userData.changeUserData (idUser: 123,
                            username: "Somebody",
                            password: "mypassword",
                            email: "some@some.ru",
                            gender: "m",
                            creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response.result {
            case .success(let changeUser):
                print (changeUser)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        productsData.downloadCatalogData(pageNumber: 1, idCategory: 1) { (response) in
            switch response.result {
            case .success(let productsData):
                print (productsData)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        productsData.downloadGoodById(idProduct: 123) { (response) in
            switch response.result {
            case .success(let goodById):
                print (goodById)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        reviewsData.addReview(idUser: 123, text: "Текст отзыва") { (response) in
            switch response.result {
            case .success(let addReview):
                print (addReview)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        reviewsData.removeReview(idComment: 1234) { (response) in
            switch response.result {
            case .success(let removeReview):
                print (removeReview)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        reviewsData.catalogReviews(idProduct: 12, pageNumber: 1) { (response) in
            switch response.result {
            case .success(let catalogReviews):
                print (catalogReviews)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GBShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

