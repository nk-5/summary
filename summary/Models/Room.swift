//
//  Room.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import Foundation

public class Room: NSObject {
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
        let items: [String]
        let state: RankState
    }

    init(id: String, users: [Room.User?], ranks: [Room.Rank?]) {
        self.id = id
        self.users = users
        self.ranks = ranks
    }
}
