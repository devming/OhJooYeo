//
//  API.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 6. 16..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON

protocol API {
    
    /// 등록된 모든 예배 id와 date 정보를 가져온다.
    /// 앱 실행 시 가장 먼저 호출되며, 가장 마지막으로 등록된 예배 id와 date를 가지고 getRecentDatas 메소드를 통해 주보 데이터를 얻기 위한 api를 호출 한다.
    ///
    /// - parameter handler: Callback Method
    ///
    /// - returns: Void
    /// - response:
    ///     [{
    ///         "date": "String",
    ///         "worshipId": "String",
    ///         "version": "String"
    ///     }]
    func getWorshipIDList(handler: @escaping (Bool, WorshipIDDate?)-> Void) -> Void
    
    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
    ///
    /// - parameter worshipId:  예배에 해당하는 ID 값
    /// - parameter version:    현재 로컬에서 가지고 있는 version 정보
    /// - parameter handler:    Callback Method
    ///
    /// - returns: Void
    func getRecentDatas(worshipIDVersion: WorshipIDDate, versionUpdateHandler: @escaping (()-> Void)) -> Void
    
    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
    ///
    /// - parameter shortcut:   성경 줄임말 문자열 - Format : 성경 a:b(~성경 c:d)(/성경 a:b(~성경 c:d))
    /// - parameter handler:    Callback Method
    ///
    /// - returns: Void
    func getPhraseMessages(shortCuts: [String], phraseMessageOrderIds: [Int], worshipID: String, handler: @escaping (()-> Void)) -> Void
    
    /// 로그인
    ///
    /// - parameter handler:    Callback Method
    ///
    /// - returns: Void
    func signIn(id: String, pw: String, handler: @escaping ((Bool)-> Void)) -> Void
}

struct APIService: API {
}

enum APIRouter {
    case getWorshipIDList()
    case getRecentDatas(worshipID: String, parameters: Parameters?)
    case getPharseMessages(parameters: Parameters?)
    case signIn(parameters: Parameters?)
}

extension APIRouter: URLRequestConvertible {
    static let baseURLString: String = "http://aaaicu.synology.me:8088/OhJooYeoMVC"
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 150 // seconds
        configuration.timeoutIntervalForResource = 30
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()

    var method: HTTPMethod {
        switch self {
        case .getWorshipIDList:
            return .get
        case .getRecentDatas:
            return .post
        case .getPharseMessages:
            return .post
        case .signIn:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getWorshipIDList():
            return "/worship-list"
        case let .getRecentDatas(worshipId, _):
            return "/worship-id/\(worshipId)"
        case .getPharseMessages(_):
            return "/phrase"
        case .signIn(_):
            return "/signin"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("Content-Type", forHTTPHeaderField: "application/json;charset=UTF-8")
        
        switch self {
        case .getWorshipIDList():
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case let .getRecentDatas(_, parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .getPharseMessages(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .signIn(parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}


