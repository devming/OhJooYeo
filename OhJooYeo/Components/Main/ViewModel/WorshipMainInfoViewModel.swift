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
    
    /// [TODO: history에서 요청할때 version을 바꾸도록..!]
    /// callApi
//    func requestWorshipMain(worshipId: String, worshipDate: String) -> Observable<WorshipMainInfo> {
    func requestWorshipMain(worshipIdDate: WorshipIdDate, version: Int = WorshipManager.shared.currentVersion) -> Observable<WorshipMainInfo?> {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId,
                                  WorshipInfoRequest.CodingKeys.worshipId.rawValue: worshipIdDate.worshipId,
                                  WorshipInfoRequest.CodingKeys.version.rawValue: worshipIdDate.version]
        print("### worshipInfo param: \(params)")
        return APIService.postWorshipInfo(parameters: params)
            .map { [weak self] data in
                guard let data = data else { return nil }
                guard let worshipInfo = try JSONDecoder().decode(WorshipMainInfo?.self, from: data) else { return nil }
                
                worshipInfo.worshipId = worshipIdDate.worshipId
                self?.worshipInfo = worshipInfo
                WorshipManager.shared.currentVersion = worshipInfo.version ?? 0
                WorshipManager.shared.currentDate = worshipIdDate.date
                WorshipManager.shared.currentWorshipId = worshipIdDate.worshipId
                
                return worshipInfo
            }
    }
    
    /// callApi
    func requestWorshipList(churchId: Int) -> Observable<[WorshipIdDate]> {
        let params: Parameters = [BaseRequest.CodingKeys.churchId.rawValue: WorshipManager.shared.churchId]
        print("### worshipInfo param: \(params)")
        return APIService.postWorshipList(parameters: params)
            .map { try JSONDecoder().decode([WorshipIdDate].self, from: $0) }
    }
}
