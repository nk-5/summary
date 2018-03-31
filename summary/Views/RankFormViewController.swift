//
//  RankFormViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import Eureka
import UIKit

class RankFormViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setFormActionButton()

        let rankTitle: String = "ランキング名"
        let rankTarget: String = "ランキング項目"
        let rankDescription: String = "ランキングの説明"

        form +++ Section(rankTitle + "（必須）")
            <<< TextRow {
                $0.tag = "rank_title"
                $0.placeholder = rankTitle
                $0.add(rule: RuleRequired())
            }

        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: rankTarget + "（必須）") {
            $0.tag = "rank_targets"
            $0.addButtonProvider = { _ in
                ButtonRow {
                    $0.title = "項目を追加"
                }.cellUpdate { cell, _ in
                    cell.textLabel?.textAlignment = .left
                }
            }
            $0.multivaluedRowToInsertAt = { _ in
                NameRow {
                    $0.placeholder = rankTarget
                }
            }
            $0 <<< NameRow {
                $0.placeholder = rankTarget
            }
                <<< NameRow {
                    $0.placeholder = rankTarget
                }
                <<< NameRow {
                    $0.placeholder = rankTarget
                }
        }

        form +++ Section(rankDescription + "（任意）")
            <<< TextAreaRow {
                $0.tag = "rank_description"
                $0.placeholder = rankDescription
            }
    }

    func setFormActionButton() {
        let actionStack: UIStackView = UIStackView(frame: CGRect(x: 0, y: view.frame.height - 200, width: view.frame.width, height: 100))
        actionStack.axis = .horizontal
        actionStack.alignment = .center
        actionStack.distribution = .fillEqually

        let cancel: UIButton = createButton(title: "キャンセル", selector: #selector(didTouchCancel))
        let create: UIButton = createButton(title: "ランキング作成", selector: #selector(didTouchCreateRank))

        actionStack.addArrangedSubview(cancel)
        actionStack.addArrangedSubview(create)

        tableView.addSubview(actionStack)
    }

    func createButton(title: String, selector: Selector) -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.setTitle(title, for: .normal)
        button.setTitleColor(view.tintColor, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    @objc func didTouchCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc func didTouchCreateRank() {
        // TODO: create rank
        // TODO: validate in view model
        print("create")
        print("\(form.values())")
    }
}
