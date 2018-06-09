//
//  RoomViewModel.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import FirebaseFirestore
import RxSwift

class RoomViewModel {
    public func findRoomById(id: String, completeHandler _: @escaping (Room?, Error?) -> Void) {
        findRanksById(id: id, completeHandler: { _, _ in
        })
    }

    public func findUsersById(id: String, completeHandler: @escaping ([Room.User?], Error?) -> Void) {
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

    public func findRanksById(id: String, completeHandler: @escaping ([Room.Rank?], Error?) -> Void) {
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
