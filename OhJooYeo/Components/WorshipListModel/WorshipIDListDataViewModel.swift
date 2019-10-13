//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import RxSwift
import Alamofire

final class WorshipIDListDataViewModel: ViewModel {
    
    var worshipIdDate: [WorshipIdDate]?
    
    override init() {
        super.init()
    }
    
    func bindWorshipIdDate() -> Observable<[WorshipIdDate]> {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        
        return APIService.postWorshipList(parameters: params)
            .map { try JSONDecoder().decode([WorshipIdDate].self, from: $0) }
            .do(onNext: { worshipIds in
                self.worshipIdDate = worshipIds
            })
    }
    
}
