//
//  [Get]WorshipIdList.swift
//  OhJooYeo
//
//  Created by Minki on 2018. 10. 4..
//  Copyright © 2018년 devming. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

extension APIService {
    
    func getWorshipIdList(handler: @escaping (Bool, WorshipIdDate?) -> Void) {
        APIRouter.manager.request(APIRouter.getWorshipIdList()).responseSwiftyJSON { (dataResponse: DataResponse<JSON>) in
            
            switch dataResponse.result {
            case .failure(let error):
                if let data = dataResponse.data {
                    print("getWorshipIdList Server Error: \(data)")
                }
                print(error)
                handler(false, nil) // - API call Fail이거나 최신 버전인 경우
                return
                
            case .success:
                /////////////////////////////////////////////////////////////////////////////////////////////////////////
                //                let result = dataResponse.map({ (json: JSON) -> [WorshipIdDate]? in
                //                    WorshipIdListData.shared.setWorshipIdList(idList: json.array)
                //
                //                    return WorshipIdListData.shared.worshipIdDate
                //                })
                /////////////////////////////////////////////////////////////////////////////////////////////////////////
                if let result = dataResponse.value {
                    WorshipIdListDAO.shared.initWorshipIdListDAO(json: result)
                }
                
                /////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                
                WorshipIdListDAO.shared.worshipIdDateList.sort {
                    return $0.worshipId > $1.worshipId
                    //                return $0.worshipId > $1.worshipId
                }
                guard let worshipIdDate = WorshipIdListDAO.shared.worshipIdDateList.first else {
                    return
                }
                /// TODO1: Local에 worshipIdDates 데이터 모두 저장
                /// TODO2: 처음일 경우(버전에 *인경우) DB에 add처리를 해야하는데 어캐할지.
                if GlobalState.shared.recentWorshipId == worshipIdDate.worshipId { /// local에 저장된 최신 ID와 서버의 최신 ID가 같으면(같은 주보에서 버전만 변경된 경우)
                    if GlobalState.shared.localVersion != worshipIdDate.version {  /// 버전이 다르면 서버에서 update가 수행된 상태임으로 파악한다.
                        if GlobalState.shared.worshipVersion != worshipIdDate.worshipVersion ||
                            GlobalState.shared.advertisementVersion != worshipIdDate.advertisementVersion ||
                            GlobalState.shared.musicVersion != worshipIdDate.musicVersion {   /// 셋 중 하나라도 버전이 다르면 가져옴.
                            
                            GlobalState.shared.localVersion = worshipIdDate.version
                            GlobalState.shared.worshipVersion = worshipIdDate.worshipVersion
                            GlobalState.shared.advertisementVersion = worshipIdDate.advertisementVersion
                            GlobalState.shared.musicVersion = worshipIdDate.musicVersion
                            
                            handler(true, worshipIdDate)   // 콜백을 통해 다음 메소드 호출
                        }
                    } else {    /// version이 같은 경우는 최신버전인 것으로 확인한다. -> 그냥 로컬에 있는 데이터 사용하면 됨
                        
                        handler(false, nil) // - API call Fail이거나 최신 버전인 경우
                    }
                } else { /// ID정보가 다를 경우(이 경우는 더 최신 새로운 날짜의 주보가 올라온 경우)
                    /* GlobalState.shared.recentWorshipId < worshipIdDate.worshipId */
                    GlobalState.shared.recentWorshipId = worshipIdDate.worshipId
                    GlobalState.shared.recentWorshipDate = worshipIdDate.date
                    GlobalState.shared.localVersion = worshipIdDate.version
                    GlobalState.shared.worshipVersion = worshipIdDate.worshipVersion
                    GlobalState.shared.advertisementVersion = worshipIdDate.advertisementVersion
                    GlobalState.shared.musicVersion = worshipIdDate.musicVersion
                    handler(true, worshipIdDate)
                }
            }
        }
        
    }
}
