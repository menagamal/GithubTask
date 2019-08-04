//
//  GithubExampleTaskTests.swift
//  GithubExampleTaskTests
//
//  Created by Mena Gamal on 8/4/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import XCTest
@testable import GithubExampleTask

class GithubExampleTaskTests: XCTestCase{
    
    
    func testInvalidUserName() {
        
        let name = "InvalidUserName"
        let viewModel = RepoViewModel()
        viewModel.repoModel = RepoModel(viewModel: viewModel)
        viewModel.getUserRepos(str: name)
        if !viewModel.items.isEmpty {
            XCTFail("ERROR")
        }
        
    }
    
    func testSavingToDb() {
        let repo = RepoModel()
        repo.name = ""
        repo.repoLanguage = ""
        repo.repoDescription = ""
        repo.repoUrl = ""
        repo.imageToBaseStr = ""
        repo.forksCount = 5
        
        if !DbManager.shared.save(item: repo) {
            XCTFail("ERROR")
        }
    }
    
    
    func testFetchingFromDb() {
        let repos = DbManager.shared.fetchAllRepos()
        if repos.isEmpty {
            XCTFail("ERROR")
        }
    }
    
    func testDeleteFromDb() {
        if !DbManager.shared.deleteAllRepos(){
             XCTFail("ERROR")
        }
    }
    
    

    
}
