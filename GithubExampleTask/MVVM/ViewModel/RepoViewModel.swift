//
//  RepoViewModel.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class RepoViewModel {
    
    var repoModel:RepoModel!
    
    var vc: UIViewController!
    
    var view:RepoView!
    
    var dataSource: ReposDataSource!
    
    var items = [RepoModel]()
    
    public enum Action {
        case  wait, idel, onError(str: String) ,getUserRepos(repos:[RepoModel])
    }
    
    init() {
        
    }
    
    init(view:RepoView,vc: UIViewController) {
        self.view = view
        self.vc = vc
        self.repoModel = RepoModel(viewModel: self)
        
    }
    
    
    func update(action: Action) {
        
        switch action {
        case .wait:
            DispatchQueue.main.async {
                LoadingView.shared.startLoading()
            }
            break
        case .idel:
            DispatchQueue.main.async {
                LoadingView.shared.stopLoading()
            }
            break
        case .onError(let str):

            Toast.showAlert(viewController: self.vc, text: str)
            break
        case .getUserRepos(let repos):
            for item in repos {
                items.append(item)
            }
            dataSource = ReposDataSource(vc: self.vc, currentTable: self.view.reposTableView, items: items,repoViewModel: self)
            break
        }
        
    }
    
    func getUserRepos(str:String) {
        repoModel.getUsersRepo(str: str)
    }
    
    func deleteAllLocalRepo()  {
        DbManager.shared.deleteAllRepos()
    }
    
    func fetchFromLocal()  {
        let repos = DbManager.shared.fetchAllRepos()
        dataSource = ReposDataSource(vc: self.vc, currentTable: self.view.reposTableView, items: repos,repoViewModel: self)
    }
    
}
