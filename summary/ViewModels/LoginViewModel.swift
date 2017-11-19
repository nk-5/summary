//
//  LoginViewModel.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import RxSwift
import Firebase

class LoginViewModel {

    public func signUp(email: String, password: String, completeHandler: @escaping (User?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            completeHandler(user, self.errorDescription(error: error))
            return
        }
    }

    public func login(email: String, password: String, completeHandler: @escaping (User?, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            completeHandler(user, self.errorDescription(error: error))
            return
        }
    }

    private func errorDescription(error: Error?) -> String? {
        guard let error = error else { return nil }
        return error.localizedDescription
    }
}