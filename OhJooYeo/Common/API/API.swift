//
//  API.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

protocol API {
//
//    /// 등록된 모든 예배 id와 date 정보를 가져온다.
//    /// 앱 실행 시 가장 먼저 호출되며, 가장 마지막으로 등록된 예배 id와 date를 가지고 getRecentDatas 메소드를 통해 주보 데이터를 얻기 위한 api를 호출 한다.
//    ///
//    /// - parameter handler: Callback Method
//    ///
//    /// - returns: Void
//    /// - response:
//    ///     [{
//    ///         "date": "String",
//    ///         "worshipId": "String",
//    ///         "version": "String"
//    ///     }]
//    func getWorshipIDList(handler: @escaping (Bool, WorshipIdDate?)-> Void) -> Void
//
//    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
//    ///
//    /// - parameter worshipId:  예배에 해당하는 ID 값
//    /// - parameter version:    현재 로컬에서 가지고 있는 version 정보
//    /// - parameter handler:    Callback Method
//    ///
//    /// - returns: Void
//    func getRecentDatas(worshipIDVersion: WorshipIdDate, versionUpdateHandler: @escaping (()-> Void)) -> Void
//
//    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
//    ///
//    /// - parameter shortcut:   성경 줄임말 문자열 - Format : 성경 a:b(~성경 c:d)(/성경 a:b(~성경 c:d))
//    /// - parameter handler:    Callback Method
//    ///
//    /// - returns: Void
//    func getPhraseMessages(shortCuts: [String], phraseMessageOrderIds: [Int], worshipID: String, handler: @escaping (()-> Void)) -> Void
//
//    /// 로그인
//    ///
//    /// - parameter handler:    Callback Method
//    ///
//    /// - returns: Void
//    func signIn(id: String, pw: String, handler: @escaping ((Bool)-> Void)) -> Void
    
}

struct APIService {
    static func postSignin(parameters: Parameters?) -> Observable<String> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postSignin(parameters: parameters))
            .responseString()
            .map { $0.1 }
    }
    
    static func postWorshipList(parameters: Parameters?) -> Observable<Data> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postWorshipList(parameters: parameters))
            .responseJSON()
            .map { $0.data }
            .debug()
            .filter { $0 != nil }
            .map { $0! }
    }
    
    static func postWorshipInfo(parameters: Parameters?) -> Observable<Data?> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postWorshipInfo(parameters: parameters))
            .responseData()
            .map { res in
                print("###### postWorshipInfo res: \(res)")
                if (res.0.allHeaderFields["Content-Length"] as? String) == "0" {
                    return nil
                }
                return res.1
            }
    }
    
    static func postPhrase(parameters: Parameters?) -> Observable<Data> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postPhrase(parameters: parameters))
            .responseJSON()
            .debug()
            .do(onNext: { (res) in
                print("###### postPhrase res: \(res)")
            })
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    static func postAd(parameters: Parameters?) -> Observable<Data?> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postAd(parameters: parameters))
            .responseData()
            .debug()
            .map { res in
//                $0.data
//                print("$0.data: \($0.1)")
                if (res.0.allHeaderFields["Content-Length"] as? String) == "0" {
                    return nil
                }
                return res.1
        }
    }
    
    static func postLaunch(parameters: Parameters?) -> Observable<Data> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postLaunch(parameters: parameters))
            .responseJSON()
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    static func postNoticeList(parameters: Parameters?) -> Observable<Data> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postNoticeList(parameters: parameters))
            .responseJSON()
            .map { $0.data }
            .filter { $0 != nil }
            .map { $0! }
    }
}

enum APIRouter {
    case postSignin(parameters: Parameters?)
    case postWorshipList(parameters: Parameters?)
    case postWorshipInfo(parameters: Parameters?)
    case postPhrase(parameters: Parameters?)
    case postAd(parameters: Parameters?)
    case postLaunch(parameters: Parameters?)
    case postNoticeList(parameters: Parameters?)
}

extension APIRouter: URLRequestConvertible {
    static let baseURLString: String = "http://aaaicu.synology.me:8088/OhJooYeoMVC"
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20 // seconds
        configuration.timeoutIntervalForResource = 30
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.urlCache = URLCache(memoryCapacity: 30, diskCapacity: 0, diskPath: nil)
        configuration.httpAdditionalHeaders = ["churchId": WorshipManager.shared.churchId]
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    var method: HTTPMethod {
        switch self {
        case .postSignin:
            return .post
        case .postWorshipList:
            return .post
        case .postWorshipInfo:
            return .post
        case .postPhrase:
            return .post
        case .postAd:
            return .post
        case .postLaunch:
            return .post
        case .postNoticeList:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .postSignin(_):
            return "/signin"
        case .postWorshipList(_):
            return "/worship/list"
        case .postWorshipInfo(_):
            return "/worship/info"
        case .postPhrase(_):
            return "/phrase"
        case .postAd(_):
            return "/worship/ad/info"
        case .postLaunch(_):
            return "/launch"
        case .postNoticeList(_):
            return "/notice/list"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case let .postSignin(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postWorshipList(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postWorshipInfo(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postPhrase(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postAd(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postLaunch(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .postNoticeList(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}


