//
//  ReposDataSource.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class ReposDataSource : NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var table:UITableView!
    var allItems = [RepoModel]()
    var items = [RepoModel]()
    var mainVc:UIViewController!
    
    var repoViewModel:RepoViewModel!
    
    init(vc:UIViewController,currentTable:UITableView,items:[RepoModel],repoViewModel:RepoViewModel) {
        super.init()
        
        self.repoViewModel = repoViewModel
        self.allItems = items

        self.mainVc = vc
        table = currentTable
        table.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        
        cell.initializeCell()
        
        cell.repoCellViewModel.setRepoModel(repo: allItems[indexPath.row])
        
        if indexPath.row == allItems.count - 1 {
            if Constants.HAS_NEXT_PAGE {
                repoViewModel.getUserRepos(str: Constants.USER_NAME)
            }
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: allItems[indexPath.row].repoUrl!), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
