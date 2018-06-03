//
//  Room.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import FirebaseFirestore
import Foundation
import RxSwift

public struct Room {
    public enum UserState: Int {
        case invited
        case joined
        case rejected

        func description() -> String {
            switch self {
            case .invited:
                return "invited"
            case .joined:
                return "joined"
            case .rejected:
                return "rejected"
            }
        }
    }

    let id: String
    let users: [Room.User?]
    let ranks: [Room.Rank?]

    struct User {
        let id: String
        let state: Room.UserState
    }

    struct Rank {
        let id: String
        let items: [Item]
        let state: RankState

        struct Item {
            var name: String
            // TODO: fix reference path
            var icon: String
        }
    }

    init(id: String, users: [Room.User?], ranks: [Room.Rank?]) {
        self.id = id
        self.users = users
        self.ranks = ranks
    }

    public static func findUsersById(id: String) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("users")

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                }
            }
        })

        // getDocument は対処のdocument idのfieldを取得する
        // そのため、document idに紐付くcollectionは取得できない
//        ref.getDocument(completion: { document, error in
//            if let document = document {
//                print(document.data())
//            } else {
//                print(error)
//            }
//        })
    }

    public static func findRanksById(id: String) {
//    public static func findRanksById(id: String) -> Room.Rank {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("ranks")

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
            } else {
                var rankList: [Rank] = [Rank]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let rank = Rank(id: document.documentID, dictionary: document.data()) else {
                        continue
                    }
                    rankList.append(rank)
                }
            }
        })
    }

//    func value<T>(forKey key: String) throws -> T {
//        guard let value = data[key] as? T else { throw ModelDataError.typeCastFailed }
//        return value
//    }
}

extension Room.Rank: DocumentSerializable {
    init?(id: String, dictionary: [String: Any]) {
        // TODO: check stateRawValue not define RankState
        guard let items = dictionary["items"] as? [String: [String: Any]],
            let stateRawValue = dictionary["state"] as? Int,
            let state = RankState(rawValue: stateRawValue) else {
            return nil
        }

        var itemList: [Item] = [Item]()
        for item in items.values {
            guard let item = Item(dictionary: item) else {
                continue
            }
            itemList.append(item)
        }
        self.init(id: id, items: itemList, state: state)
    }
}

extension Room.Rank.Item {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let icon = dictionary["icon"] as? String else {
            return nil
        }
        self.init(name: name, icon: icon)
    }
}
