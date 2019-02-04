//
//  [Post]RecentDatas.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

extension APIService {
    
    func getRecentDatas(worshipIDVersion: WorshipIDDate, versionUpdateHandler: @escaping (() -> Void)) {
        let worshipID = worshipIDVersion.worshipID
        APIRouter.manager.request(APIRouter.getRecentDatas(worshipID: worshipID, parameters: nil)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
            case .failure(let error):
                print("getRecentDatas API Error -> \(error)")
                return
            case .success:
                /// [API JSON data -> Model]
                if let result = dataResponse.value {
                    WholeWorshipDataDAO.shared.initWorshipData(json: result, worshipID: worshipID) { orderList in
                        self.getPhraseMessageShortCutWithOrderId(orderList: orderList, worshipID: worshipID)
                    }
                }
                
                versionUpdateHandler()
            }
        }
    }
    
    /**
     성경말씀 shortcut 이름 찾는 부분
     ex) 여호수아 1:5
     */
    func getPhraseMessageShortCutWithOrderId(orderList: List<WorshipOrder>?, worshipID: String) {
        var details = [String]()
        var orderIDs = [Int]()
        
        orderList?
            .filter { (order) -> Bool in
                return order.type == WorshipOrder.TypeName.phrase.rawValue
            }
            .forEach { (order) in
                details.append(order.detail)
                orderIDs.append(order.orderID)
            }
        
//        for order in orderList {
//            if order.type == WorshipOrder.TypeName.phrase.rawValue {
//                details.append(order.detail)
//                orderIDs.append(order.orderID)
//            }
//        }
        
        App.api.getPhraseMessages(shortCuts: details, phraseMessageOrderIds: orderIDs, worshipID: worshipID) { }
    }
}
