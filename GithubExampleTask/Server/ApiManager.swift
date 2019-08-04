//
//  ApiManager.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import ObjectMapper
public class ApiManager: BaseUrlSession {
    
    var delegate: ApiManagerDelegate!
    let baseUrl = Constants.BASE_URL
    
    public enum ActionType {
        case getAllUsersRepos,None
    }
    
    override init() {
        super.init()
        
    }
    
    convenience init<T: ApiManagerDelegate>(delegate: T)  {
        self.init()
        
        self.delegate = delegate
    }
    
    func getAllUsersRepos(str:String) {
        let  params =  [String: Any]()
        
        let actionType = ActionType.getAllUsersRepos
        
        let url = URL(string: "\(baseUrl)/\(str)/repos?per_page=7&page=\(Constants.PAGES_COUNT)")!
        
        requestConnection(action: actionType, method: "get", url: url, body: params, shouldCache: false)
    }
    
    func getUDID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    override func onPreExecute(action: Any) {
        delegate.onPreExecute(action: action as! ApiManager.ActionType)
    }
    
    func onPreExecute(action: ActionType) {
        delegate.onPreExecute(action: action)
    }
    
    override func onSuccess(action: Any, response: URLResponse!, data: Data!) {
        
        let actionType: ActionType = action as! ApiManager.ActionType
        let res = String(data: data, encoding: .utf8)
        print(res ?? "")
        
        do {
            var jsonObject = [String:Any]()
            var jsonArray = [[String: Any]]()
            var success = true
            var code = 200
            var errorMessage:String!
            if let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] {
                
                jsonArray = object
            }
            if let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                
                jsonObject = object
               
                if let responeMessage = jsonObject["message"] as? String{
                    errorMessage = responeMessage
                    success = false
                    code = 404
                }
            }
            
            if success {
                switch actionType {
                case .getAllUsersRepos:
                    if jsonArray.isEmpty {
                        Constants.HAS_NEXT_PAGE = false 
                    } else {
                        Constants.PAGES_COUNT += 1 
                    }
                    var repos = [RepoModel]()
                    for item in jsonArray {
                        let repo = RepoModel(JSON: item)
                        repos.append(repo!)
                    }
                    delegate.onPostExecute(status: Status(code, true, ""), action: actionType, response: repos)
                    
                default:
                    break
                }
            } else {
                
                onFailure(action: actionType, error: NSError(domain: errorMessage, code: code, userInfo: nil))
            }
        } catch {
            
            onFailure(action: actionType, error: error as NSError)
        }
    }
    
    override func onFailure(action: Any, error: NSError) {
        delegate.onPostExecute(status: Status(error: error), action: action as! ApiManager.ActionType, response: nil)
    }
}

public protocol ApiManagerDelegate {
    
    func onPreExecute(action: ApiManager.ActionType)
    
    func onPostExecute(status: BaseUrlSession.Status, action: ApiManager.ActionType, response: Any!)
}
