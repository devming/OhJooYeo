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
    
    func getPhraseMessages(shortCut: String, phraseMessageOrderId: Int32, handler: @escaping (() -> Void)) {
        let parameter: Parameters = ["phraseRange": shortCut]
        APIRouter.manager.request(APIRouter.getPharseMessages(shortCut: shortCut, parameters: parameter)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
                
            case .failure(let error):
                if let data = dataResponse.data {
                    print("getPharseMessages Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                }
                print(error)
                
            case .success(_):
                let result = dataResponse.map({ (json: JSON) -> [Model.PhraseMessage]? in
                    guard let messages = json.array else {
                        print("json.array error")
                        return nil
                    }
                    var messageList = [Model.PhraseMessage]()
                    for message in messages {
                        guard let data = Model.PhraseMessage(json: message) else {
                            continue
                        }
                        messageList.append(data)
                    }
                    return messageList
                })
                
                if let responseWholeDatas = result.value, let data = responseWholeDatas {
                    PhraseMessageCellData.shared.setPhraseMessages(phraseMessageModels: data)
                }
                handler()
            }
        }
    }
    
}
