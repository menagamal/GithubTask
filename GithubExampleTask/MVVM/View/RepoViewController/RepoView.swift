//
//  RepoView.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

protocol RepoView {
    
    var reposTableView: UITableView!{
        get set
    }
    
    var repoViewModel: RepoViewModel! {
        get set
    }
    
}

