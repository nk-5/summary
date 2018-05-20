//
//  User.swift
//  summary
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import Foundation

// TODO: add Organizations
public struct User {
    public enum Gender: Int {
        case male
        case female
        case unknown
    }

    struct Room {
        let id: String
    }

    struct Rank {
        let id: String
    }

    let id: String
    let rooms: [User.Room?]
    let ranks: [User.Rank?]
    let age: Int?
    let email: String?
    let icon: Data?
    let password: String?
    let gender: User.Gender?

    init(id: String, rooms: [User.Room?], ranks: [User.Rank?], age: Int?, email: String?, icon: Data?, password: String?, gender: User.Gender?) {
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
