//
//  HomeViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTouchCreateRank(_: Any) {
        let storyboard = UIStoryboard(name: "RankForm", bundle: nil)
        let vc:RankFormViewController = storyboard.instantiateInitialViewController() as! RankFormViewController
        self.present(vc, animated: true, completion: nil)
    }
}
