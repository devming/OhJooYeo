//
//  LoginViewController.swift
//  OhJooYeo
//
//  Created by Minki on 02/05/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: OJYUITextField!
    @IBOutlet weak var passwordTextField: OJYUITextField!
    @IBOutlet weak var loginButton: OJYUIButton!
    @IBOutlet weak var signupButton: OJYUIButton!
    
    let viewModel = LoginViewModel()
    
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    let test = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isValidEmail = emailTextField.rx.text.orEmpty
            .skipWhile(viewModel.emptyTextField)
            .map(viewModel.validateEmail)
        
        let isValidPassword = passwordTextField.rx.text.orEmpty
            .skipWhile(viewModel.emptyTextField)
            .map(viewModel.validatePassword)
        
        isValidEmail
            .map(viewModel.validateChangeTextField)
            .distinctUntilChanged()
            .bind(to: emailTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        isValidPassword
            .map(viewModel.validateChangeTextField)
            .distinctUntilChanged()
            .bind(to: passwordTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(isValidEmail, isValidPassword) { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { b in self.loginButton.isEnabled = b })
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .map { (self.emailTextField.text, self.passwordTextField.text) }
            .filter { $0.0 != nil && $0.1 != nil }
            .map { _ -> (String?, String?) in return ("admin", "admin") }     /// TODO: [테스트용코드] 이건 반드시 지울것
            .flatMap { self.viewModel.callLogin(id: $0.0!, pw: $0.1!) }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isSuccess in
                GlobalState.shared.autoLogin = isSuccess
                if isSuccess {
                    self.performSegue(withIdentifier: "mainSegue", sender: self)
                }
            }).disposed(by: disposeBag)
            
        
        
//        /// Test Code
//        if test {
//            self.performSegue(withIdentifier: "mainSegue", sender: self)
//            return
//        }
//
//        if GlobalState.shared.autoLogin {
//            loginCompletionHandler() {
//
//                self.performSegue(withIdentifier: "mainSegue", sender: self)
//            }
//            return
//        }
    }
    
    //    func controlKeyboardConstraint() {
//
//        self.bottomConstraint.constant = 50
//
//        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
//
//            /// 키보드의 영역 크기를 가져오는 부분이다.
//            if let value = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//                let frame = value.cgRectValue
//                let height = frame.size.height
//
//                self?.bottomConstraint.constant = height + 50
//
//                UIView.animate(withDuration: 0.3, animations: { [weak self] in
//                    self?.view.layoutIfNeeded()
//                })
//            }
//        }
//
//        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (noti) in
//            if let _ = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//                self.bottomConstraint.constant = 50
//
//                UIView.animate(withDuration: 0.3, animations: { [weak self] in
//                    self?.view.layoutIfNeeded()
//                })
//            }
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
}
