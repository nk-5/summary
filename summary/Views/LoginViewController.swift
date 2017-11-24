//
//  LoginViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FacebookLogin

let minimalEmailLength = 3
let minimalPasswordLength = 8

class LoginViewController: UIViewController, LoginButtonDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIView!

    let loginViewModel: LoginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        validateLogin()
        createFacebookLoginButton()
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

    func createFacebookLoginButton() {
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
    }

    @IBAction func didTouchLogin(_: Any) {
        guard let email = self.email.text else { return }
        guard let password = self.password.text else { return }

        loginViewModel.login(email: email, password: password, completeHandler: { _, errorMessage in
            guard let errorMessage = errorMessage else { return }
            // alert error message
            print(errorMessage)
        })
    }

    // Facebook LoginButtonDelegate
    func loginButtonDidCompleteLogin(_: LoginButton, result: LoginResult) {
        switch result {
        case let .success(grantedPermissions: grantedPermission,
                          declinedPermissions: declinedPermissions,
                          token: AccessToken):
            print("login")
            print(grantedPermission)
            print(declinedPermissions)
            print(AccessToken)
        case .cancelled:
            print("cancel")
        case let .failed(error):
            print(error)
        }
    }

    func loginButtonDidLogOut(_: LoginButton) {
    }
}
