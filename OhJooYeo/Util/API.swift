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
    func getRecentDatas(date: Date, version: String, handler: @escaping (()-> Void)) -> Void
}

struct OhJooYeoAPI: API {
    func getRecentDatas(date: Date, version: String, handler: @escaping (() -> Void)) {
        let parameters: Parameters = ["page": date, "version": version]
        APIRouter.manager.request(APIRouter.getRecentDatas(date: date, version: version, parameters: parameters)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            let result = dataResponse.map({ (json: JSON) -> Model.Version? in
                guard let data = Model.Version(json: json) else {
                    return nil
                }
                return data
            })
            
            print(result)
        }
    }
}

enum APIRouter {
    case getRecentDatas(date: Date, version: String, parameters: Parameters)
}

extension APIRouter: URLRequestConvertible {
    static let baseURLString: String = "https://api.github.com"
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
        case .getRecentDatas:
            return .post
        }
    }

    var path: String {
        switch self {
        case let .getRecentDatas(date, version, _):
            return "/version/\(date)/\(version)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case let .getRecentDatas(_, _, parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }


}


