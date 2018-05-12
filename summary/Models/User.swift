//
//  User.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import Foundation

public enum Gender: Int {
    case male
    case female
    case unknown
}

// TODO: add Organizations
public class User: NSObject {
    struct Room {
        let id: String
    }

    struct Rank {
        let id: String
    }

    let id: String
    let rooms: [Room?]
    let ranks: [Rank?]
    let age: Int?
    let email: String?
    let icon: Data?
    let password: String?
    let gender: Gender?

    init(id: String, rooms: [Room?], ranks: [Rank?], age: Int?, email: String?, icon: Data?, password: String?, gender: Gender?) {
        self.id = id
        self.rooms = rooms
        self.ranks = ranks
        self.age = age
        self.email = email
        self.icon = icon
        self.password = password
        self.gender = gender
    }
}
