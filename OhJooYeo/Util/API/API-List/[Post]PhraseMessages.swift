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
    
    func getPhraseMessages(shortCuts: [String], phraseMessageOrderIds: [Int32], handler: @escaping (() -> Void)) {
        let parameter: Parameters = ["phraseRange": shortCuts]
        APIRouter.manager.request(APIRouter.getPharseMessages(parameters: parameter)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
                
            case .failure(let error):
                guard let data = dataResponse.data else {
                    print(error)
                    return
                }
                print(data)
//                fallthrough
                
            case .success(_):
                let result = dataResponse.map({ (json: JSON) -> [[Model.PhraseMessage]]? in
                    guard let messages = json.array else {
                        print("json.array error")
                        return nil
                    }
                    var messageLists = [[Model.PhraseMessage]]()
                    for i in 0..<messages.count {
                        var messageList = [Model.PhraseMessage]()
                        guard let rawMessage = messages[i].array else {
                            print("json.array error")
                            return nil
                        }
                        for msg in rawMessage {
                            guard var data = Model.PhraseMessage(json: msg) else {
                                continue
                            }
                            data.shortCut = shortCuts[i]
                            data.orderId = phraseMessageOrderIds[i]
                            
                            messageList.append(data)
                        }
                        messageLists.append(messageList)
                    }
                    return messageLists
                })
                
                if let responseWholeDatas = result.value, let data = responseWholeDatas {
                    PhraseMessageCellData.shared.setPhraseMessages(phraseMessageModelLists: data)
                }
                handler()
            }
        }
    }
    
}
