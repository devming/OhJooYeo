//
//  [Post]RecentDatas.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIService {
    
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
                    
                    guard let data = Model.Worship(json: json) else {
                        return nil
                    }
                    return data
                })
                
                /// result가 네트워크상에서 받아온 데이터를 객체로 가지고 있음.
                if let responseWholeDatas = result.value, let data = responseWholeDatas {
                    WorshipCellData.shared.setWorship(worship: data, id: GlobalState.shared.recentWorshipId)
                }
                
                handler()
            }
        }
    }
    
}
