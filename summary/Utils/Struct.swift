//
//  Struct.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

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

// struct User {
//    var name: String
// }

// TODO: classにするのと、構成を変える
struct Rank {
    var name: String
    var state: RankState
    var targets: [String]
    //    var users: [User]
}

// struct Room {
//    var name: String
//    var ranks: [Rank]
// }
