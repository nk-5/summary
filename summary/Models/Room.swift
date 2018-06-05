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

    public struct User {
        let id: String
        let state: Room.UserState
    }

    public struct Rank {
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

    public static func findUsersById(id: String, completeHandler: @escaping ([Room.User?], Error?) -> Void) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("users")
        var userList: [Room.User] = [Room.User]()

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                completeHandler(userList, error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let user = Room.User(id: document.documentID, dictionary: document.data()) else {
                        continue
                    }
                    userList.append(user)
                }
                completeHandler(userList, nil)
            }
        })
    }

    public static func findRanksById(id: String, completeHandler: @escaping ([Room.Rank?], Error?) -> Void) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("ranks")
        var rankList: [Room.Rank] = [Room.Rank]()

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                completeHandler(rankList, error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let rank = Room.Rank(id: document.documentID, dictionary: document.data()) else {
                        continue
                    }
                    rankList.append(rank)
                }
                completeHandler(rankList, nil)
            }
        })
    }
}

extension Room.User: DocumentSerializable {
    init?(id: String, dictionary: [String: Any]) {
        guard let stateRawvalue = dictionary["state"] as? Int,
            let state = Room.UserState(rawValue: stateRawvalue) else {
                return nil
        }
        self.init(id: id, state: state)
    }
}

extension Room.Rank: DocumentSerializable {
    init?(id: String, dictionary: [String: Any]) {
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
