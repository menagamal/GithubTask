//
//  RepoTableCellView.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/4/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

protocol RepoTableCellView {
    
    
    var userImageView: CircularImageView!{
        get set
    }
    
    var labelCreationDate: UILabel!{
        get set
    }
    var labelRepoTitle: UILabel!{
        get set
    }
    var labelLanguage: UILabel!{
        get set
    }
    var labelFolksCount: UILabel!{
        get set
    }
    var labelDescription: UILabel!{
        get set
    }
    
    
    var repoCellViewModel: RepoCellViewModel! {
        get set
    }
    
}
