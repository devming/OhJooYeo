//
//  [Post]PhraseMessages.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIService {
    
    func getPhraseMessages(shortCuts: [String], phraseMessageOrderIds: [Int], worshipMO: WorshipMO?, handler: @escaping (() -> Void)) {
        let parameter: Parameters = ["phraseRange": shortCuts]
        APIRouter.manager.request(APIRouter.getPharseMessages(parameters: parameter)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
                
            case .failure(let error):
                guard let data = dataResponse.data else {
                    print(error)
                    return
                }
                print(data)
                
            case .success(_):
                let result = dataResponse.map({ (json: JSON) -> [[PhraseMessage]] in
                    return PhraseMessageDAO.shared.initPhraseMessageData(json: json)
                })
                
                if let data = result.value {
                    PhraseMessageViewModel.shared.setPhraseMessages(phraseMessageModelLists: data, worshipMO: worshipMO)
                }
                handler()
            }
        }
    }
}
