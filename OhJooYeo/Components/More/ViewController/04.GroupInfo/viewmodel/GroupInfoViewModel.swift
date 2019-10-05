//
//  GroupInfoViewModel.swift
//  OhJooYeo
//
//  Created by Minki on 03/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift

class GroupInfoViewModel: ViewModel {
    
    private var groupInfo: GroupInfo?
    
    func initializer() {
        
    }
    
    func loadGroupInfoDatas() -> GroupInfo? {
        
//        App.api.~~~~
        
        self.groupInfo = GroupInfo(title: "돈암동감리교회 청년부", content: "청년부는 크게 1부와 2부로 구성되어있습니다. 1부는 20세(수능이끝난 고3의 다음해) ~ 25세까지이고, 2부는 26세 ~ 미혼인 청년이 속하게 됩니다.", image: "img_young_intro")
        
        return groupInfo
    }
}

