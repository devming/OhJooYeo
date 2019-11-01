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
    var phrases: [PhraseMessage]?
    
    func callApi(phraseRange: [String]) -> Observable<[PhraseMessage]> {
        let param: Parameters = [PhraseMessageRequest.CodingKeys.phraseRange.rawValue: phraseRange]
        
        return APIService.postPhrase(parameters: param)
            .map { try JSONDecoder().decode([PhraseMessage].self, from: $0) }
            .do(onNext: { phraseMessages in
                self.phrases = phraseMessages
            })
    }
}
