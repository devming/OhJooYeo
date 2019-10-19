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
    var advertisements: [Advertisement]
    
    override init() {
        advertisements = [Advertisement]()
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
    
    func callData() -> Observable<Advertisement> {
        let params: Parameters = [AdvertisementRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        
        return APIService.postAd(parameters: params)
            .map { try JSONDecoder().decode(Advertisement.self, from: $0) }
            .map { advertisement -> Advertisement in
                self.advertisements.append(advertisement)
                return advertisement
            }
    }
}
