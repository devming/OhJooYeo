//
//  AdvertisementCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Alamofire
import RxSwift

final class AdvertisementViewModel: ViewModel {
    var advertisements: [Advertisement]?
    
    override init() {
        super.init()
        
//        bindRx()
    }
    
//    private func bindRx() {
//        let params: Parameters = [AdvertisementRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
//
//        APIService.postAd(parameters: params)
//            .map { try JSONDecoder().decode(Advertisement.self, from: $0) }
//            .subscribe(onNext: { advertisement in
//                self.advertisements.append(advertisement)
//            }).disposed(by: disposeBag)
//    }
    
    func requestAdvertisements() -> Observable<[Advertisement]?> {
//        let params: Parameters = [AdvertisementRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId,
                                  WorshipInfoRequest.CodingKeys.worshipId.rawValue: WorshipManager.shared.currentWorshipId,
                                  WorshipInfoRequest.CodingKeys.version.rawValue: WorshipManager.shared.currentVersion]
        
        return APIService.postAd(parameters: params)
            .map { [weak self] data in
                guard let data = data else { return nil }
                let advertisement = try JSONDecoder().decode(AdvertisementResponse.self, from: data)
                self?.advertisements = advertisement.worshipAd
                return advertisement.worshipAd
            }
    }
}
