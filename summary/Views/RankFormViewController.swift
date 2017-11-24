//
//  RankFormViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import Eureka

class RankFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setFormActionButton()

        let rankTitle: String = "ランキング名"
        let rankTarget: String = "ランキング項目"
        let rankDescription: String = "ランキングの説明（任意）"

        form +++ Section(rankTitle)
            <<< TextRow { row in
                row.placeholder = rankTitle
            }

        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: rankTarget) {
            $0.tag = "textfields"
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

        form +++ Section(rankDescription)
            <<< TextAreaRow { row in
                row.placeholder = rankDescription
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
        // TODO: back home or room
        print("cancel")
    }

    @objc func didTouchCreateRank() {
        // TODO: create rank
        print("create")
    }
}
