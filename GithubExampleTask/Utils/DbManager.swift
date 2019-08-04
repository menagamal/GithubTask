//
//  DbManager.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DbManager {
    
    var vc:UIViewController!
    
    static let shared = DbManager()

    private init() {   
    }
    
    
    
    
    func save(item:RepoModel) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "RepoEntity",
                                                in: managedContext)!
        
        let repo = NSManagedObject(entity: entity,insertInto: managedContext)
        
        repo.setValue(item.name, forKey: "name")
        repo.setValue(item.repoLanguage, forKey: "repoLanguage")
        repo.setValue(item.repoDescription, forKey: "repoDescription")
        repo.setValue(item.repoUrl, forKey: "repoUrl")
        repo.setValue(item.imageToBaseStr, forKey: "imageToBaseStr")
        repo.setValue(item.forksCount, forKey: "forksCount")
        
        do {
            try managedContext.save()
            print("saveed")
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        return false
    }
    
    func saveArrayOfRepos(repos:[RepoModel]) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RepoEntity",
                                                in: managedContext)!
        
        for item in repos {
            let repo = NSManagedObject(entity: entity,insertInto: managedContext)
            repo.setValue(item.name, forKey: "name")
            repo.setValue(item.repoLanguage, forKey: "repoLanguage")
            repo.setValue(item.repoDescription, forKey: "repoDescription")
            repo.setValue(item.repoUrl, forKey: "repoUrl")
            repo.setValue(item.imageToBaseStr, forKey: "imageToBaseStr")
            repo.setValue(item.forksCount, forKey: "forksCount")

        }
        do {
            try managedContext.save()
            print("Success")
            return true
        } catch {
            print("Error saving: \(error)")
        }
        return false
    }
    
    func deleteAllRepos() -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RepoEntity")

        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
                return true
            }
        } catch let error {
            print("Detele all data  error :", error)
        }
        return false
    }
  
    
    func fetchAllRepos() -> [RepoModel] {
        
        var repos = [RepoModel]()
        
        var reposObject: [NSManagedObject] = []

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return [RepoModel]()
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RepoEntity")
        
        //3
        do {
            reposObject = try managedContext.fetch(fetchRequest)
            
            
            for item in reposObject {
                
                let repo = RepoModel()
                repo.name = item.value(forKeyPath: "name") as? String
                repo.repoLanguage = item.value(forKeyPath: "repoLanguage") as? String
                repo.repoDescription = item.value(forKeyPath: "repoDescription") as? String
                repo.repoUrl = item.value(forKeyPath: "repoUrl") as? String
                repo.imageToBaseStr = item.value(forKeyPath: "imageToBaseStr") as? String
                repo.forksCount = item.value(forKeyPath: "forksCount") as? Int
                repos.append(repo)
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return repos
    }
    
}
