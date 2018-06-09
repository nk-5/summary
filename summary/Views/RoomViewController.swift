//
//  RoomViewController.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

struct SectionOfRoomRank {
    var items: [Item]
}

extension SectionOfRoomRank: SectionModelType {
    typealias Item = Room.Rank

    init(original _: SectionOfRoomRank, items: [Item]) {
        self.items = items
    }
}

class RoomViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var rankView: UITableView!

    var roomRanks: [Room.Rank?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        rankView.delegate = self

//        Room.findById(id: "0")
//        Room.findRanksById(id: "0")

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfRoomRank>(
            configureCell: { (_: TableViewSectionedDataSource<SectionOfRoomRank>, tv: UITableView, _: IndexPath, item: Room.Rank) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.textLabel?.text = "\(item.id) 状態：\(item.state.description())"
                return cell
        })

        // TODO: datasource get from Firestore
        let section = [
            SectionOfRoomRank(items: [
                Room.Rank(id: "test rank name", items: [Room.Rank.Item(name: "test", icon: "icon"), Room.Rank.Item(name: "hoge", icon: "icon"), Room.Rank.Item(name: "fuga", icon: "icon")], state: RankState.prepare),
                Room.Rank(id: "hogehoge rank name", items: [Room.Rank.Item(name: "test", icon: "icon"), Room.Rank.Item(name: "hoge", icon: "icon"), Room.Rank.Item(name: "fuga", icon: "icon")], state: RankState.finished),
                Room.Rank(id: "fugafuga rank name", items: [Room.Rank.Item(name: "test", icon: "icon"), Room.Rank.Item(name: "hoge", icon: "icon"), Room.Rank.Item(name: "fuga", icon: "icon")], state: RankState.open),
            ]),
        ]

        Observable.just(section)
            .bind(to: rankView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        roomRanks = section[0].items
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select rank. index path is \(indexPath.row)")
        let storyboard: UIStoryboard = UIStoryboard(name: "VoteView", bundle: nil)
        let vc: VoteViewController = storyboard.instantiateInitialViewController() as! VoteViewController
        vc.rank = roomRanks[indexPath.row]
        show(vc, sender: nil)
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
