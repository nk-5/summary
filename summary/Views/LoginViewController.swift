//
//  LoginViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 3
let minimalPasswordLength = 8

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let loginViewModel: LoginViewModel = LoginViewModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        validateLogin()
    }

    func validateLogin() {
        let usernameValid = username.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1, scope: .whileConnected)

        let passwordValid = password.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1, scope: .whileConnected)

        let validLogin = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1, scope: .whileConnected)

        usernameValid
            .bind(to: password.rx.isEnabled)
            .disposed(by: disposeBag)

        validLogin
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @IBAction func didTouchLogin(_ sender: Any) {
        loginViewModel.login()
    }
}
