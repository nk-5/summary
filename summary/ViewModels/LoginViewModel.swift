//
//  LoginViewModel.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import RxSwift
import Firebase

class LoginViewModel {

    public func login(email: String, password: String, completeHandler: @escaping (User?, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            completeHandler(user, error?.localizedDescription)
            return
        }
    }
}
