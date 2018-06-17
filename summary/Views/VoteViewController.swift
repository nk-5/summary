//
//  VoteViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import RxSwift
import UIKit

class VoteViewController: UIViewController {
    @IBOutlet var rankTitle: UILabel!
    @IBOutlet var targetsView: UIStackView!
    @IBOutlet var voteButton: UIButton!

    var rank: Room.Rank?
    let selectButtons = ReplaySubject<UIButton>.createUnbounded()
    var selectedItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: add error handling

        guard let name = rank?.id else { return }
        rankTitle.text = name

        createTargetSubView()

        voteButton.rx.tap.subscribe({ [weak self] _ in
            // TODO: vote button tapped show alert
            let storyboard: UIStoryboard = UIStoryboard(name: "VoteView", bundle: nil)
            let avc: AggregateViewController = storyboard.instantiateViewController(withIdentifier: "aggregateView") as! AggregateViewController
            avc.selectedItem = self?.selectedItem
            self?.show(avc, sender: nil)
        }).disposed(by: disposeBag)
    }

    func createTargetSubView() {
        guard let items = rank?.items else { return }
        Observable.from(items).map({ target in let targetView: UIStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
            targetView.axis = .horizontal
            targetView.distribution = .fill

            let targetName = UILabel()
            targetName.text = target.name
            targetView.addArrangedSubview(targetName)

            let targetSelectButton = UIButton()
            targetSelectButton.setTitle("select", for: .normal)
            targetSelectButton.setTitleColor(self.view.tintColor, for: .normal)
            targetSelectButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
            targetView.addArrangedSubview(targetSelectButton)
            targetSelectButton.rx.tap
                .subscribe({ _ in
                    self.selectedItem = target.name
                    self.changeSelectButtonTitle()
                    targetSelectButton.setTitle("selected", for: .normal)

                    // when select button enabled
                    self.voteButton.isEnabled = true
                })
                .disposed(by: disposeBag)

            self.selectButtons.onNext(targetSelectButton)

            self.targetsView.insertArrangedSubview(targetView, at: 0)
            targetView.leadingAnchor.constraint(equalTo: self.targetsView.leadingAnchor, constant: 0).isActive = true
            targetView.leftAnchor.constraint(equalTo: self.targetsView.leftAnchor, constant: 0).isActive = true
        }).subscribe {
            print($0)
        }.disposed(by: disposeBag)
    }

    func changeSelectButtonTitle() {
        selectButtons.subscribe({
            guard let button = $0.element else { return }
            if button.isEnabled {
                button.setTitle("select", for: .normal)
            }
        }).disposed(by: disposeBag)
    }

    @IBAction func didTouchCancel(_: Any) {
        dismiss(animated: true, completion: nil)
    }
}
