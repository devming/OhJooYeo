//
//  [Post]SignIn.swift
//  OhJooYeo
//
//  Created by Minki on 01/06/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension APIService {

    func signIn(id: String, pw: String, handler: @escaping ((Bool) -> Void)) {
        
        let parameter: Parameters = ["id": id, "pw": pw]
        APIRouter.manager.request(APIRouter.signIn(parameters: parameter)).responseJSON { (response: DataResponse<Any>) in
            
            switch response.result {
            case .failure(let error):
                guard let data = response.data else {
                    print(error)
                    return
                }
                print(data)
                
            case .success(_):
                let _ = response.map({ (result: Any) -> Void in
                    guard let isSuccess = result as? Bool else {
                        return
                    }
                    
                    handler(isSuccess)
                    return
                })
            }
            
        }
    }
    
}
