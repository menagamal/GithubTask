//
//  RepoCellViewModel.swift
//  GithubExampleTask
//
//  Created by Mena Gamal on 8/4/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire


class RepoCellViewModel {
    
    private var repo:RepoModel!
    
    private var view:RepoTableCellView!
    
    
    init( view:RepoTableCellView) {
        
        self.view = view
        
    }
    
    func setRepoModel(repo:RepoModel) {
        self.repo = repo
        setAllUiLayout()
    }
    
    private func setAllUiLayout() {
        
        self.view.labelCreationDate.text = repo.createdAt
        self.view.labelRepoTitle.text = repo.name
        if let lang = repo.repoLanguage {
            self.view.labelLanguage.text = "Langouage : \(lang)"
        }
        if let count = repo.forksCount {
            self.view.labelFolksCount.text = "Forks Count : \(count)"
        }
        
        self.view.labelDescription.text = repo.repoDescription
        
        if repo.imageUrl != nil {
            
            self.getImageFromUrl(str: repo.imageUrl!)
            
        } else {
            let dataDecoded : Data = Data(base64Encoded: repo.imageToBaseStr!, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            self.view.userImageView.image = decodedimage
        }
        
    }
    private  func getImageFromUrl(str:String) {
        
        Alamofire.request(str).responseImage { response in
            
            if let image = response.result.value {
                
                print("image downloaded: \(image)")
                self.view.userImageView.image = image
                self.saveToDB()
            }
        }
    }
    private func saveToDB(){
        let imageData = self.view.userImageView.image!.pngData()
        repo.imageToBaseStr = imageData!.base64EncodedString(options: .lineLength76Characters)
        
        if DbManager.shared.save(item: repo) {
            print("Saved")
        } else {
            print("ERROR saving")
        }
    }
    
}
