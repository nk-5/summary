//
//  LoginViewModel.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import RxSwift
import Firebase

class LoginViewModel {

    public func login(email: String, password: String, completeHandler: @escaping (User?, AuthErrorCode?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            guard let user = user else {
                completeHandler(nil, AuthErrorCode(rawValue: error!._code)!)
                return
            }
            return completeHandler(user, nil)
        }
    }
}
