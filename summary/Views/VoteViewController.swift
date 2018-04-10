//
//  VoteViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {
    @IBOutlet var rankTitle: UILabel!
    @IBOutlet var targets: UIStackView!

    var rank: Rank?

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: add error handling
        // TODO: set rank target

        guard let name = rank?.name else { return }
        rankTitle.text = name
        createTargetSubView()
    }

    func createTargetSubView() {
        let target: UIStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        target.axis = .horizontal
        target.distribution = .fill

        let targetName = UILabel()
        // rank.target
        targetName.text = "target name"
        target.addArrangedSubview(targetName)

        let targetSelectButton = UIButton()
        targetSelectButton.setTitle("select", for: .normal)
        targetSelectButton.setTitleColor(view.tintColor, for: .normal)
        target.addArrangedSubview(targetSelectButton)

        targets.insertArrangedSubview(target, at: 0)
    }

    @IBAction func didTouchCancel(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}
