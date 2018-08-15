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
    func getMusicImageDatas(musicImageId: Int, handler: @escaping ((UIImage)-> Void)) -> Void
}

struct OhJooYeoAPI: API {
    func getRecentDatas(date: Date, version: String, handler: @escaping (() -> Void)) {
        let parameters: Parameters = [:]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko")
        guard var dateString = formatter.string(for: date) else {
            return
        }
        print(dateString)
        dateString = "2018-08-04"
        
        APIRouter.manager.request(APIRouter.getRecentDatas(date: dateString, version: version, parameters: parameters)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result
            {
            case .failure(let error):
                if let data = dataResponse.data {
                    print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                }
                print(error)
                
            case .success(let value):
                
                print(value)
            }
            
            
            
//            if dataResponse.error != nil {
            
                let result = dataResponse.map({ (json: JSON) -> Model.Version? in
                    print("json data: \(json)")
                    
                    guard let data = Model.Version(json: json) else {
                        return nil
                    }
                    return data
                })
            
            print("result:\(result)")
//            } else {
//                print("response error")
//            }
        }
    }
    
    func getMusicImageDatas(musicImageId: Int, handler: @escaping ((UIImage) -> Void)) {
        
        // Use Alamofire to download the image
        // Content-Type: image/png
        let parameters: Parameters = ["id": musicImageId]
        APIRouter.manager.request(APIRouter.getMusicImageDatas(parameters: parameters)).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
//                if let data = response.data, let image = UIImage(data: data) {
//                    handler(image)
//                }
            }
        }
    }
    
}

enum APIRouter {
    case getRecentDatas(date: String, version: String, parameters: Parameters?)
    case getMusicImageDatas(parameters: Parameters)
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
        case .getRecentDatas:
            return .post
        case .getMusicImageDatas:
            return .post
        }
    }

    var path: String {
        switch self {
        case let .getRecentDatas(date, version, _):
            return "/date/\(date)/check/version/\(version)"
//            return "/date/\(date)/check/version\(version)"
        case .getMusicImageDatas(_):
            return "/music"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("Content-Type", forHTTPHeaderField: "application/json;charset=UTF-8")
        
        switch self {
        case let .getRecentDatas(_, _, parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case let .getMusicImageDatas(parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }


}


