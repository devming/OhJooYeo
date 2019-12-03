//
//  PhraseMessageViewModel.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/13.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift
import Alamofire

class PhraseMessageViewModel: ViewModel {
    var phrases: [[PhraseMessage]]?
    
    /// callApi
    func requestPhraseMessage(phraseRange: [String]) -> Observable<[[PhraseMessage]]> {
//        let param: Parameters = [PhraseMessageRequest.CodingKeys.phraseRange.rawValue: phraseRange]
        let param: Parameters = [PhraseMessageRequest.CodingKeys.phraseRange.rawValue: phraseRange]
        
        
        return APIService.postPhrase(parameters: param)
            .map { [weak self] data in
                let phraseMessages = try JSONDecoder().decode([[PhraseMessage]].self, from: data)
                self?.phrases = phraseMessages
                return phraseMessages
            }
    }
}
