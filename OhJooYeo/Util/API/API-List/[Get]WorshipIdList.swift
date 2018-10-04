//
//  [Get]WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIService {
    
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
    
}
