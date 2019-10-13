//
//  [Post]PhraseMessages.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension APIService {
    
//    func getPhraseMessages(shortCuts: [String], phraseMessageOrderIds: [Int], worshipID: String, handler: @escaping (() -> Void)) {
//        let parameter: Parameters = ["phraseRange": shortCuts]
//        APIRouter.manager.request(APIRouter.getPharseMessages(parameters: parameter)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
//
//            switch dataResponse.result {
//
//            case .failure(let error):
//                guard let data = dataResponse.data else {
//                    print(error)
//                    return
//                }
//                print(data)
//
//            case .success(_):
//                let _ = dataResponse.map({ (json: JSON) -> Void in
//                    WholeWorshipDataDAO.shared.initPhraseMessageListData(orderIDs: phraseMessageOrderIds, worshipID: worshipID, json: json, completionHandler: nil)
//                })
//                
//                handler()
//            }
//        }
//    }
}
