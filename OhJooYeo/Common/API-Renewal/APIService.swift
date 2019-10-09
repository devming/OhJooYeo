//
//  API-Service.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/08.
//  Copyright © 2019 devming. All rights reserved.
//

import Foundation
import Alamofire
//import RxAlamofire
import RxSwift
import SwiftyJSON

extension APIService {
    static func request(url:String,
                        method:HTTPMethod,
                        parameters: [String: Any]? = nil,
                        body:Data? = nil,
                        header:[String: String]? = nil) -> Observable<JSON> {
        let observable:Observable<JSON> =  Observable.create({ (subscriber) -> Disposable in
            
            let timeout = Timer.scheduledTimer(timeInterval: NetworkDefine.TIMEOUT_INTERVAL,
                                               target: self,
                                               selector: #selector(self.timeout),
                                               userInfo:subscriber,
                                               repeats: false)
            
            var requestUrl = url
            var requestBody:Data? = nil
            let encoding = URLEncoding.default
            var originalRequest: URLRequest?
            do {
                
                if let reqBody = body {
                    do {
                        if let query = parameters?.queryString {
                            let concat = url.contains("?") ? "&" : "?"
                            requestUrl = url + concat + query
                        }
                        
                        originalRequest = try URLRequest(url: requestUrl,
                                                         method: method,
                                                         headers: header)
                        requestBody = reqBody
                        originalRequest?.httpBody = requestBody
                    } catch {
                        print("error \(error)")
                        subscriber.onError(error)
                    }
                } else {
                    originalRequest = try URLRequest(url: requestUrl,
                                                     method: method,
                                                     headers: header)
                    let encodedURLRequest = try encoding.encode(originalRequest!, with: parameters)
                    originalRequest = encodedURLRequest
                }
                
                return requestData(originalRequest!)
                    .subscribe( onNext:{(response, data) in
                        if timeout.isValid == true {
                            timeout.invalidate()
                            
                            let jsonObject = JSON(data)
                            let error = jsonObject["error"]
                            if error.isEmpty == false {
                                do {
                                    let data = try error.rawData()
                                    
                                    let responseError = try JSONDecoder().decode(ApiError.self, from:data)
                                    subscriber.onError(NSError(domain: "Response Error", code: -1,
                                                               userInfo: ["error" : responseError]))
                                } catch {
                                    subscriber.onError(NSError(domain: "Response Error", code: -1, userInfo: ["error" :ApiError()]))
                                }
                            }
                            else{
                                subscriber.onNext(jsonObject)
                                subscriber.onCompleted()
                            }
                        }
                    }, onError: { (error) in
                        print("error \(error)")
                        subscriber.onError(error)
                    })
            } catch {
                print("error \(error)")
                subscriber.onError(error)
            }
            return Disposables.create()
        })
        
        return observable
    }
}
