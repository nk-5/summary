//
//  AggregateViewController.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import UIKit

class AggregateViewController: UIViewController {
    @IBOutlet var aggregateView: UIStackView!
    @IBOutlet var voteRate: UILabel!
    // TODO: 締め切りボタンタップ時はアラート出す
    @IBOutlet var closeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: get aggregate data
    }

    @IBAction func didTouchCancel(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}
