//
//  WorshipCellData.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 8. 25..
//  Copyright © 2018년 devming. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

final class WorshipMainInfoViewModel: ViewModel {
    
//    private let mainPresenterSubject = BehaviorSubject<String>(value: " ")
//    var mainPresenterObservable: Observable<String> {
//        get { return mainPresenterSubject.asObservable() }
//    }
    private let worshipInfoSubject = PublishSubject<WorshipMainInfo?>()
    var worshipInfoObservable: Observable<WorshipMainInfo?> {
        get { return worshipInfoSubject.asObservable() }
    }
    var worshipInfo: WorshipMainInfo? {
        didSet {
            self.worshipInfoSubject.onNext(self.worshipInfo)
//            self.mainPresenterSubject.onNext(self.worshipInfo?.mainPresenter ?? " ")
        }
    }
    
    override init() {
        super.init()
    }
    
    /// callApi
    func requestWorshipMain(worshipId: String) -> Observable<WorshipMainInfo> {
        
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId,
                                  WorshipInfoRequest.CodingKeys.worshipId.rawValue: worshipId,
                                  WorshipInfoRequest.CodingKeys.version.rawValue: WorshipManager.shared.currentWorshipInfo?.version ?? 0]
        print("### worshipInfo param: \(params)")
        return APIService.postWorshipInfo(parameters: params)
            .map { try JSONDecoder().decode(WorshipMainInfo.self, from: $0) }
            .do(onNext: { [weak self] (worshipInfo) in
                print("### worshipInfo: \(worshipInfo)")
                self?.worshipInfo = worshipInfo
            })
    }
}
