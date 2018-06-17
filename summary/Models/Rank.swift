//
//  Rank.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import FirebaseFirestore

public enum RankState: Int {
    case prepare
    case open
    case finished

    func description() -> String {
        switch self {
        case .prepare:
            return "prepare"
        case .open:
            return "open"
        case .finished:
            return "finished"
        }
    }
}

public struct Rank {
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

    struct User {
        let state: Rank.UserState
        let result: [String: Int]
    }

    struct Item {
        let name: String
        var counts: Int
        // TODO: cloud storage reference path
        let icon: String
    }

    let id: String
    let users: [User?]
    let admin: String
    // TODO: カテゴリづけ
    let category: String?
    let items: [Item]
    let deadline: Timestamp
    // TODO: cloud storage reference, type change reference??
//    let icon: Data?
    let icon: String?
    let permission: Int
    let minimumRequirement: Int
    let resultScope: Bool
    let scope: Bool
    let state: RankState
    let type: Int
    let comments: [String: String?]

    init(id: String, users: [User?], admin: String, category: String, items: [Item], deadline: Timestamp, icon: String?, permission: Int, minimumRequirement: Int, resultScope: Bool, scope: Bool, state: RankState, type: Int, comments: [String: String?]) {
        self.id = id
        self.users = users
        self.admin = admin
        self.category = category
        self.items = items
        self.deadline = deadline
        self.icon = icon
        self.permission = permission
        self.minimumRequirement = minimumRequirement
        self.resultScope = resultScope
        self.scope = scope
        self.state = state
        self.type = type
        self.comments = comments
    }
}

extension Rank.User {
    init?(dictionary: [String: Any]) {
        guard let result = dictionary["result"] as? [String: Int],
            let stateRawValue = dictionary["state"] as? Int,
            let state = Rank.UserState(rawValue: stateRawValue) else {
            return nil
        }

        self.init(state: state, result: result)
    }
}

extension Rank.Item {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let counts = dictionary["counts"] as? Int,
            let icon = dictionary["icon"] as? String else {
            return nil
        }

        self.init(name: name, counts: counts, icon: icon)
    }
}
