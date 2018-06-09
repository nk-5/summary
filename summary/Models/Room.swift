//
//  Room.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import Foundation

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
