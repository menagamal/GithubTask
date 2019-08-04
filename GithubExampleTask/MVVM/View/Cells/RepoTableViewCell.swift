//
//  RepoTableViewCell.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/3/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell ,RepoTableCellView{
    
    var repoCellViewModel: RepoCellViewModel!
    
    @IBOutlet weak var userImageView: CircularImageView!
    
    @IBOutlet weak var labelCreationDate: UILabel!
    @IBOutlet weak var labelRepoTitle: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var labelFolksCount: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    func initializeCell(){
            repoCellViewModel = RepoCellViewModel(view: self)
    }
    
    
    
}
