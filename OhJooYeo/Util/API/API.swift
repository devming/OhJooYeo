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
    func getWorshipIdList(handler: @escaping ()-> Void) -> Void
    func getRecentDatas(worshipId: String, version: String, handler: @escaping (()-> Void)) -> Void
}

struct APIService: API {
    func getWorshipIdList(handler: @escaping () -> Void) {
        APIRouter.manager.request(APIRouter.getWorshipIdList()).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result
            {
            case .failure(let error):
                if let data = dataResponse.data {
                    print("getWorshipIdList Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                }
                print(error)
                
            case .success:
                let result = dataResponse.map({ (json: JSON) -> [Model.WorshipIdDate]? in
                    print("json data: \(json)")
                    
                    WorshipIdListData.shared.setWorshipIdList(idList: json.array)
                    
                    return WorshipIdListData.shared.worshipIdDate
                })
                if let responseData = result.value, var worshipIdDates = responseData {
                    
                    worshipIdDates.sort {
                        return $0.worshipId < $1.worshipId
                        //                return $0.worshipId > $1.worshipId
                    }
                    guard let worshipIdDate = worshipIdDates.first else {
                        return
                    }
                    GlobalState.shared.recentWorshipId = worshipIdDate.worshipId
                    GlobalState.shared.recentWorshipDate = worshipIdDate.date
                }
                
                handler()
            }
        }
    }
    
    func getRecentDatas(worshipId: String, version: String, handler: @escaping (() -> Void)) {
        APIRouter.manager.request(APIRouter.getRecentDatas(worshipId: worshipId, version: version, parameters: nil)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result
            {
            case .failure(let error):
                if let data = dataResponse.data {
                    print("getRecentDatas Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                }
                print(error)
                
            case .success:
                let result = dataResponse.map({ (json: JSON) -> Model.Worship? in
                    print("json data: \(json)")
                    
                    guard let data = Model.Worship(json: json) else {
                        return nil
                    }
                    return data
                })
                
                /// result가 네트워크상에서 받아온 데이터를 객체로 가지고 있음.
                if let responseWholeDatas = result.value, let data = responseWholeDatas {
//                    WorshipCellData.shared.setWorship(worship: data, version: GlobalState.shared.version, date: GlobalState.shared.recentWorshipDate, id: GlobalState.shared.recentWorshipId)
                    WorshipCellData.shared.setWorship(worship: data, id: GlobalState.shared.recentWorshipId)
                }
            }
        }
    }
}

enum APIRouter {
    case getWorshipIdList()
    case getRecentDatas(worshipId: String, version: String, parameters: Parameters?)
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
        }
    }

    var path: String {
        switch self {
        case .getWorshipIdList():
            return "/worship-list"
        case let .getRecentDatas(worshipId, version, _):
            return "/worship-id/\(worshipId)/check/version/\(version)"
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
        }

        return urlRequest
    }
}


