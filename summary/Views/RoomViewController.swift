//
//  RoomViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

enum RankState: Int {
    case ready
    case voting
    case finished

    func description() -> String {
        switch self {
        case .ready:
            return "準備中"
        case .voting:
            return "開催中"
        case .finished:
            return "終了"
        }
    }
}

// TODO: public/private rank use common struct
struct RoomRank {
    var name: String
    var state: String
}

struct SectionOfRoomRank {
    var items: [Item]
}

extension SectionOfRoomRank: SectionModelType {
    typealias Item = RoomRank

    init(original _: SectionOfRoomRank, items: [Item]) {
        self.items = items
    }
}

class RoomViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var rankView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        rankView.delegate = self

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfRoomRank>(
            configureCell: { (_: TableViewSectionedDataSource<SectionOfRoomRank>, tv: UITableView, _: IndexPath, item: RoomRank) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = "\(item.name) 状態：\(item.state)"
                return cell
        })

        // TODO: datasource get from Firestore
        let section = [
            SectionOfRoomRank(items: [
                RoomRank(name: "test rank name", state: RankState.ready.description()),
                RoomRank(name: "hogehoge rank", state: RankState.voting.description()),
                RoomRank(name: "fugafuga rank", state: RankState.finished.description()),
            ]),
        ]

        Observable.just(section)
            .bind(to: rankView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: present Ranking detail view
        print("select rank. index path is \(indexPath.row)")
    }

    @IBAction func didTouchCreateRank(_: Any) {
        let vc: RankFormViewController = RankFormViewController()
        present(vc, animated: true, completion: nil)
    }

    @IBAction func didTouchShare(_: Any) {
        // TODO: modal display share options
        print("share")
    }
}
