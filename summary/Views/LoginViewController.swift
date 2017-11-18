//
//  LoginViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

let minimalEmailLength = 3
let minimalPasswordLength = 8

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let loginViewModel: LoginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        validateLogin()
    }

    func validateLogin() {
        let emailValid: Observable = email.rx.text.orEmpty
            .map { $0.count >= minimalEmailLength }
            .share(replay: 1, scope: .whileConnected)

        let passwordValid: Observable = password.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1, scope: .whileConnected)

        let validLogin: Observable = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
            .share(replay: 1, scope: .whileConnected)

        emailValid
            .bind(to: password.rx.isEnabled)
            .disposed(by: disposeBag)

        validLogin
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    @IBAction func didTouchLogin(_: Any) {
        guard let email = self.email.text else { return }
        guard let password = self.password.text else { return }

        loginViewModel.login(email: email, password: password, completeHandler: { _, authErrorCode in
            guard let error = authErrorCode else {
                return
            }

            switch error {
            case .wrongPassword:
                // TODO: alert view
                print("wrong password")
            case .invalidEmail:
                print("invalid email")
            default: break
            }
        })
    }
}
