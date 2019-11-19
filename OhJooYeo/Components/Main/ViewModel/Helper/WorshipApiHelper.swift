//
//  WorshipApiHelper.swift
//  OhJooYeo
//
//  Created by Minki on 2019/11/17.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift

class WorshipApiHelper {
    
//    static func requestWorshipOrder() -> Observable<[WorshipOrder]> {
//
//    }
    
    static func requestYearlyMessage() -> Observable<String> {
        return Observable.of("네 믿음을 내게 보이라 나는 행함으로 내 믿음을 네게 보이리라 하리라 - 야고보서 2:18 -")
    }
}
