//
//  VoteViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {
    var rank: Rank?

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: add error handling
        guard let rankName = rank?.name else { return }
        print(rankName)
    }
}
