//
//  [Post]RecentDatas.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIService {
    
    func getRecentDatas(worshipIDVersion: Model.WorshipIdDate, versionUpdateHandler: @escaping (() -> Void)) {
        let worshipId = worshipIDVersion.worshipId
        APIRouter.manager.request(APIRouter.getRecentDatas(worshipId: worshipId, parameters: nil)).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
            case .failure(let error):
                print("getRecentDatas API Error -> \(error)")
                return
            case .success:
                /// [API JSON data -> Model]
                let result = dataResponse.map({ (json: JSON) -> Model.Worship? in
                    
                    guard let data = Model.Worship(json: json) else {
                        return nil
                    }
                    return data
                })
                
                /// result가 네트워크상에서 받아온 데이터를 객체로 가지고 있음.
                if let responseWholeDatas = result.value, let worshipData = responseWholeDatas {
                    /// [Model -> CoreData]
                    if worshipIDVersion.worshipVersion == "\(ConstantString.notSetVersion)" { // 현재 로컬 버전이 최초 아무것도 없는 경우(*인경우) - Add
                        DbManager.shared.addWorship(mainPresenter: worshipData.mainPresenter, worshipOrder: worshipData.worshipOrders, nextPresenter: worshipData.nextPresenter, version: worshipIDVersion.version, worshipDate: worshipData.worshipDate, worshipId: worshipIDVersion.worshipId)
                    } else {
                        DbManager.shared.updateWorship(mainPresenter: worshipData.mainPresenter, worshipOrder: worshipData.worshipOrders, nextPresenter: worshipData.nextPresenter, version: worshipIDVersion.version, worshipDate: worshipData.worshipDate, worshipId: worshipIDVersion.worshipId)
                    }
                    
                    let worshipMO = DbManager.shared.getRecentWorship()
                    
                    if worshipIDVersion.advertisementVersion == "\(ConstantString.notSetVersion)" {
                        DbManager.shared.addAdvertisement(advertisements: worshipData.advertisements, worshipMO: worshipMO)
                    } else {
                        DbManager.shared.updateAdvertisement(advertisements: worshipData.advertisements, worshipMO: worshipMO)
                    }
                    
                    if worshipIDVersion.musicVersion == "\(ConstantString.notSetVersion)" {
                        DbManager.shared.addMusic(musics: worshipData.musics, worshipMO: worshipMO)
                    } else {
                        DbManager.shared.updateMusic(musics: worshipData.musics, worshipMO: worshipMO)
                    }
                    
                    /// [Model -> ViewModel]: 받아온 데이터를 사용할 View Model에 저장
                    WorshipViewModel.shared.setWorship(worship: worshipData, worshipIDVersion: worshipIDVersion) { worshipMO in
                        self.getPhraseMessageShortCutWithOrderId(orderList: worshipData.worshipOrders, worshipMO: worshipMO)
                        AdvertisementViewModel.shared.setAdvertisement(advertisementModels: worshipData.advertisements, worshipMO: worshipMO)
                        MusicViewModel.shared.setMusic(musicModels: worshipData.musics, worshipMO: worshipMO)
                    }
                }
                
                versionUpdateHandler()
            }
        }
    }
    
    /**
     성경말씀 shortcut 이름 찾는 부분
     ex) 여호수아 1:5
     */
    func getPhraseMessageShortCutWithOrderId(orderList: [Model.WorshipOrder], worshipMO: WorshipMO?) {
        var details = [String]()
        var orderIds = [Int32]()
        
        for order in orderList {
            if order.type == Model.WorshipOrder.TypeName.phrase.rawValue {
                details.append(order.detail)
                orderIds.append(order.orderId)
            }
        }
        
        App.api.getPhraseMessages(shortCuts: details, phraseMessageOrderIds: orderIds, worshipMO: worshipMO) { }
    }
}
