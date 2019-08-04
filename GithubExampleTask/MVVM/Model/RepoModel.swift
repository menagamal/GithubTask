//
//  RepoModel.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftDate

class RepoModel : Mappable , ApiManagerDelegate {
    
    //name,avatar_url,git_url,description,created_at,forks_count
    var name:String?
    var imageUrl:String?
    var repoUrl:String?
    var repoDescription:String?
    var createdAt:String?
    var forksCount:Int?
    var repoLanguage:String?
    var imageToBaseStr:String?
    
    private var content:ApiManager!
    private var viewModel:RepoViewModel!
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        var ownerDict = [String:Any]()
        
        name                                <- map["name"]
        repoUrl                             <- map["clone_url"]
        repoDescription                     <- map["description"]
        
        createdAt                           <- map["created_at"]
        if let temp = createdAt {
            createdAt = temp.toISODate()?.toString()
        }
        
        forksCount                          <- map["forks_count"]
        repoLanguage                        <- map["language"]
        ownerDict                           <- map["owner"]
        imageUrl                            = ownerDict["avatar_url"] as? String ?? ""
        
        content = ApiManager(delegate: self)
        
    }
    
    
    init(viewModel:RepoViewModel) {
        content = ApiManager(delegate: self)
        self.viewModel = viewModel
    }
    
    func getUsersRepo(str:String)  {
        let trimmedString = str.trimmingCharacters(in: .whitespaces)
        content.getAllUsersRepos(str: trimmedString)
    }
    
    
    func onPreExecute(action: ApiManager.ActionType) {
        viewModel.update(action: .wait)
    }
    
    func onPostExecute(status: BaseUrlSession.Status, action: ApiManager.ActionType, response: Any!) {
        viewModel.update(action: .idel)
        if status.success {
            switch action {
            case .getAllUsersRepos:
                let repos = response as! [RepoModel]
                viewModel.update(action:.getUserRepos(repos: repos))
                break
            default:
                break
            }
        } else {
            viewModel.update(action: .onError(str: status.message))
        }
    }
}
