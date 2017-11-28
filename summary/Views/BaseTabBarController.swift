//
//  BaseTabBarController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import Firebase

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        let loginViewModel: LoginViewModel = LoginViewModel()
        loginViewModel.anonymousLogin(completeHandler: { user, error in
            // TODO: error handling
            guard let user = user else { return }
            guard let error = error else { return }
            print(user)
            print(error)
        })
    }
}
