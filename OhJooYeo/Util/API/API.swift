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
    func getWorshipIdList(handler: @escaping ()-> Void) -> Void
    
    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
    ///
    /// - parameter worshipId:  예배에 해당하는 ID 값
    /// - parameter version:    현재 로컬에서 가지고 있는 version 정보
    /// - parameter handler:    Callback Method
    ///
    /// - returns: Void
    func getRecentDatas(worshipId: String, version: String, handler: @escaping (()-> Void)) -> Void
    
    /// 해당 예배 ID값을 가지고 등록된 주보 정보를 가져오는 API 호출 메소드
    ///
    /// - parameter shortcut:   성경 줄임말 문자열 - Format : 성경 a:b(~성경 c:d)(/성경 a:b(~성경 c:d))
    /// - parameter handler:    Callback Method
    ///
    /// - returns: Void
    func getPhraseMessages(shortCut: String, phraseMessageOrderId: Int32, handler: @escaping (()-> Void)) -> Void
}

struct APIService: API {}

enum APIRouter {
    case getWorshipIdList()
    case getRecentDatas(worshipId: String, version: String, parameters: Parameters?)
    case getPharseMessages(shortCut: String, parameters: Parameters?)
}

extension APIRouter: URLRequestConvertible {
    static let baseURLString: String = "http://ec2-52-79-233-2.ap-northeast-2.compute.amazonaws.com:8080/OhJooYeoMVC"
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()

    var method: HTTPMethod {
        switch self {
        case .getWorshipIdList:
            return .get
        case .getRecentDatas:
            return .post
        case .getPharseMessages:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getWorshipIdList():
            return "/worship-list"
        case let .getRecentDatas(worshipId, version, _):
            return "/worship-id/\(worshipId)/check/version/\(version)"
        case .getPharseMessages(_, _):
            return "/phrase"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("Content-Type", forHTTPHeaderField: "application/json;charset=UTF-8")
        
        switch self {
        case .getWorshipIdList():
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        case let .getRecentDatas(_, _, parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .getPharseMessages(_, parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}


