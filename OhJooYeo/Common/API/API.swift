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

typealias ResponseData = (responseStatus: ResponseStatus, data: Data?)
enum ResponseStatus: Int {
    case success = 200
    case networkError = 400
    case serverError = 500
    case noData = 0
    case unknownError = 1000
}

struct APIService {
    static func postSignin(parameters: Parameters?) -> Observable<String> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postSignin(parameters: parameters))
            .responseString()
            .map { $0.1 }
    }
    
    static func postWorshipList(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postWorshipList(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    static func postWorshipInfo(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postWorshipInfo(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    static func postPhrase(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postPhrase(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    static func postAd(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postAd(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    static func postLaunch(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postLaunch(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    static func postNoticeList(parameters: Parameters?) -> Observable<ResponseData> {
        
        return APIRouter.manager.rx
            .request(urlRequest: APIRouter.postNoticeList(parameters: parameters))
            .responseData()
            .map { resultData($0) }
    }
    
    private static func convertStatusCode(code: Int) -> ResponseStatus {
        switch code {
        case 200..<300:
            return .success
        case 400 ..< 500:
            return .networkError
        case 500 ..< 600:
            return .serverError
        case 0:
            return .noData
        default:
            return .unknownError
        }
    }
    
    private static func resultData(_ response: (HTTPURLResponse, Data)) -> ResponseData {
        var responseStatus = convertStatusCode(code: response.0.statusCode)
        var data: Data? = response.1
        if (response.0.allHeaderFields["Content-Length"] as? String) == "0" {    /// 데이터가 없을 때 처리
            responseStatus = convertStatusCode(code: 0)
            data = nil
        }
        
        return ResponseData(responseStatus: responseStatus, data: data)
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
