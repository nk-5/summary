//
//  VoteViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {

    var rankName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: add error handling
        guard let rankName = rankName else { return }
        print(rankName)
    }
}
