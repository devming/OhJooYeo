//
//  LoginViewModel.swift
//  OhJooYeo
//
//  Created by Minki on 18/05/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import RxSwift
import Alamofire

final class LoginViewModel: ViewModel {
    
//    let loginSubject = PublishSubject<Login
    
    func validateEmail(_ emailString: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailString)
    }
    
    /// TODO: 패스워드 체크는 회원가입시에만 할것.
    func validatePassword(_ passwordString: String) -> Bool {
        return true
//        let passwordRegex = """
//        (?=^.{6,255}$)((?=.*\\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*
//        """
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: passwordString)
    }
    
    func validateChangeTextField(_ isValid: Bool) -> UIColor {
        if isValid {
            return UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.2)
        }
        return UIColor(displayP3Red: 0.8, green: 0, blue: 0, alpha: 0.2)
    }
    
    func emptyTextField(_ text: String) -> Bool {
        return text.isEmpty
    }
    
    func callLogin(id: String, pw: String, completionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        let params: Parameters = ["id": id, "pw": pw]
        APIService.postSignin(parameters: params)
            .subscribe(onNext: { result in
                if result == "true" {
                    print("로그인 성공")
                    WorshipManager.shared.churchId = 1
                } else {
                    print("로그인 실패")
                }
            })
            .disposed(by: disposeBag)
//        App.api.signIn(id: id, pw: pw) { isSuccess in
//            if isSuccess {
//                completionHandler()
//            } else {
//                errorHandler()
//            }
//        }
    }
}
