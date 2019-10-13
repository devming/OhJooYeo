//
//  BaseRequest.swift
//  OhJooYeo
//
//  Created by Minki on 2019/10/12.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift
import Alamofire

class BaseRequest: Encodable {
    var churchId: Int?
 
    enum CodingKeys: String, CodingKey {
        case churchId = "churchId"
    }
}
