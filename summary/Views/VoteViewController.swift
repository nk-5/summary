//
//  VoteViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {
    @IBOutlet var rankTitle: UILabel!
    @IBOutlet var targetsView: UIStackView!

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
        // TODO: refactor RxSwift
        guard let targets = rank?.targets else { return }
        for target in targets {
            let targetView: UIStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
            targetView.axis = .horizontal
            targetView.distribution = .fill

            let targetName = UILabel()
            targetName.text = target
            targetView.addArrangedSubview(targetName)

            let targetSelectButton = UIButton()
            targetSelectButton.setTitle("select", for: .normal)
            targetSelectButton.setTitleColor(view.tintColor, for: .normal)
            targetSelectButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            targetView.addArrangedSubview(targetSelectButton)

            targetsView.insertArrangedSubview(targetView, at: 0)
            targetView.leadingAnchor.constraint(equalTo: targetsView.leadingAnchor, constant: 0).isActive = true
            targetView.leftAnchor.constraint(equalTo: targetsView.leftAnchor, constant: 0).isActive = true
        }
    }

    @IBAction func didTouchCancel(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}
