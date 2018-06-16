//
//  GlobalState.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation


final class GlobalState {
    static let instance = GlobalState()
    
    enum Sample: String {
        case tokenKey
        case refreshTokenKey
        case ownerKey
        case repoKey
        case reposKey
    }
    
    enum Constants: String {
        case currentVersion
    }
    
    var version: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.currentVersion.rawValue) ?? "####"
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.currentVersion.rawValue)
        }
    }
    
//    func addRepo(owner:String, repo: String) {
//        let dict = ["owner": owner, "repo" : repo]
//        var repos: [[String: String]] = (UserDefaults.standard.array(forKey: Sample.reposKey.rawValue) as? [[String : String]]) ?? []
//        repos.append(dict)
//        
//        UserDefaults.standard.set(NSSet(array: repos).allObjects, forKey: Sample.reposKey.rawValue)
//    }
//    var repos: [(owner: String, repo:String)] {
//        let repoDicts: [[String: String]] = (UserDefaults.standard.array(forKey: Sample.reposKey.rawValue) as? [[String : String]]) ?? []
//        let repos = repoDicts.map { (repoDict: [String: String]) -> (String, String) in
//            let owner = repoDict["owner"] ?? ""
//            let repo = repoDict["repo"] ?? ""
//            return (owner, repo)
//        }
//        return repos
//    }
}

