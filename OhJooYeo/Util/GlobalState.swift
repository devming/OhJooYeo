//
//  GlobalState.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation


final class GlobalState {
    static let shared = GlobalState()
    
    enum Constants: String {
        case currentVersion
        case recentWorshipId
    }
    
    var version: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.currentVersion.rawValue) ?? "***"
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.currentVersion.rawValue)
        }
    }
    
    var recentWorshipId: String {
        get {
            let recentWorshipId = UserDefaults.standard.string(forKey: Constants.recentWorshipId.rawValue) ?? "---" ///TODO: 서버에서 예외처리
            return recentWorshipId
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.recentWorshipId.rawValue)
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

