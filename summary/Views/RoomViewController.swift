//
//  RoomViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var rankView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTouchCreateRank(_: Any) {
        let vc: RankFormViewController = RankFormViewController()
        present(vc, animated: true, completion: nil)
    }

    @IBAction func didTouchShare(_ sender: Any) {
        // TODO: modal display share options
        print("share")
    }
}
