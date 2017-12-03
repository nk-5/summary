//
//  Struct.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

public enum RankState: Int {
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

// struct User {
//    var name: String
// }

struct Rank {
    var name: String
    var state: RankState
    //    var users: [User]
}

struct Room {
    var name: String
    var ranks: [Rank]
}
