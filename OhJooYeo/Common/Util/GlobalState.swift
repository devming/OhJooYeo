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
        case localVersion
        case worshipVersion
        case advertisementVersion
        case musicVersion
        case recentWorshipID
        case recentWorshipDate
        case autoLogin
    }
    
    var localVersion: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.localVersion.rawValue) ?? ConstantString.notSetVersions
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.localVersion.rawValue)
        }
    }
    
    var worshipVersion: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.worshipVersion.rawValue) ?? ConstantString.notSetVersions
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.worshipVersion.rawValue)
        }
    }
    
    var advertisementVersion: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.advertisementVersion.rawValue) ?? ConstantString.notSetVersions
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.advertisementVersion.rawValue)
        }
    }
    
    var musicVersion: String {
        get {
            let version = UserDefaults.standard.string(forKey: Constants.musicVersion.rawValue) ?? ConstantString.notSetVersions
            return version
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.musicVersion.rawValue)
        }
    }
    
    var recentWorshipID: String {
        get {
            let recentWorshipID = UserDefaults.standard.string(forKey: Constants.recentWorshipID.rawValue) ?? "---" ///TODO: 서버에서 예외처리
            return recentWorshipID
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.recentWorshipID.rawValue)
        }
    }
    
    var recentWorshipDate: String {
        get {
            let recentWorshipDate = UserDefaults.standard.string(forKey: Constants.recentWorshipDate.rawValue) ?? ConstantString.definedStringNoValue
            return recentWorshipDate
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.recentWorshipDate.rawValue)
        }
    }
    
    var autoLogin: Bool {
        get {
            let isAutoLoginSuccess = UserDefaults.standard.bool(forKey: Constants.autoLogin.rawValue) ?? false
            return isAutoLoginSuccess
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.autoLogin.rawValue)
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

