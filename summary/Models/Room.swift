//
//  Room.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

public enum UserRoomState: Int {
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

class Room {
    let id: String
    let users: [User]
    let ranks: [Rank]

    struct User {
        let id: String
        let state: UserRoomState
    }

    struct Rank {
        let id: String
        let items: [String]
        let state: RankState
    }

}
