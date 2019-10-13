//
//  API-Service.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/08.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON

extension APIService {
    static func request() {
        Alamofire.request("http://aaaicu.synology.me:8088/OhJooYeoMVC").responseJSON { response in
            debugPrint(response)
        }
        
        let manager = SessionManager.default
        let parameter = ["dd": 0]
        let header = ["churchId": "0"]
        
//        manager.rx.responseJSON(<#T##method: HTTPMethod##HTTPMethod#>, <#T##url: URLConvertible##URLConvertible#>, parameters: <#T##[String : Any]?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##[String : String]?#>)
//        manager.rx.json(.post, APIRouter.baseURLString, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        
//        APIRouter.manager.session.configuration.httpAdditionalHeaders = ["churchId":"d"]
    }
    
}
