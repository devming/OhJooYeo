//
//  WorshipIdListData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 9. 7..
//  Copyright © 2018년 devming. All rights reserved.
//

import Alamofire

final class WorshipIDListDataViewModel: ViewModel {
    
    var worshipIdDate: [WorshipIdDate]?
    
    override init() {
        super.init()
        bindRx()
    }
    
    private func bindRx() {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        
            APIService.postWorshipList(parameters: params)
            .map { try JSONDecoder().decode([WorshipIdDate].self, from: $0) }
            .subscribe(onNext: { worshipIds in
                self.worshipIdDate = worshipIds
            }).disposed(by: disposeBag)
    }
    
}
