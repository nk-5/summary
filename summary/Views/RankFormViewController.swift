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

        // TODO: cannot text input
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
}
