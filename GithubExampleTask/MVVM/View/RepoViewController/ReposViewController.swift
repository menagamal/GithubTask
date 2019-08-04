//
//  ViewController.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import Alamofire

class ReposViewController: UIViewController ,RepoView{
   
    var repoViewModel: RepoViewModel!
 
    @IBOutlet weak var reposTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoViewModel = RepoViewModel(view: self, vc: self)
        
        if NetworkReachabilityManager()!.isReachable {
            
            repoViewModel.deleteAllLocalRepo()
            repoViewModel.getUserRepos(str: Constants.USER_NAME)
        } else {
            repoViewModel.fetchFromLocal()
        }
        
    }
    
}

