//
//  ChurchInfoViewModel.swift
//  OhJooYeo
//
//  Created by Minki on 18/08/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift

class ChurchInfoViewModel: ViewModel {
    
    private var churchInfo: ChurchInfo?
    var testContent = """
힘든 삶에 지쳐있는 모든 사람들과 갈 바를 알지 못하는 사람들에게 참평안을 주시고 인생의 바른 길로 인도하시는 분이 계십니다.

그 분은 예수 그리스도이십니다.
예수님은 당신을 사랑하십니다.

돈암동교회는 그 분을 만날 수 있도록 안내하며,
그 분과 함께 사는 것이 얼마나 행복하고 복된 지를 경험하게 하는 참 좋은 교회입니다.

하나님이 기뻐하시는 교회, 사랑과 선행으로 서로를 격려하는 교회(히 10:24), 돈암동교회 홈페이지에 오신 여러분들을 환영합니다.
"""
    func initializer() {
        
    }
    
    func loadChurchInfoDatas() -> ChurchInfo? {
        
        //        App.api.~~~~
        
        self.churchInfo = ChurchInfo(title: "돈암동감리교회", content: testContent, image: "img_church_intro")
        
        return churchInfo
    }
}
