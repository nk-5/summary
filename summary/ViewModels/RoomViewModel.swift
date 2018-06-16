//
//  RoomViewModel.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import FirebaseFirestore
import RxSwift

class RoomViewModel {
    private let roomSubject: PublishSubject = PublishSubject<Room>()
    private let roomUsersSubject: PublishSubject = PublishSubject<[Room.User]>()
    private let roomRanksSubject: PublishSubject = PublishSubject<[Room.Rank]>()

    var room: Observable<Room> { return roomSubject }

    public func findRoomById(id: String) {
        let observable = Observable.combineLatest(roomUsersSubject, roomRanksSubject, resultSelector: {
            users, ranks in
            Room(id: id, users: users, ranks: ranks)
        })

        observable.subscribe(onNext: { room in
            self.roomSubject.onNext(room)
        }).disposed(by: disposeBag)

        findUsersById(id: id)
        findRanksById(id: id)
    }

    private func findUsersById(id: String) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("users")
        var userList: [Room.User] = [Room.User]()

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
//        ref.getDocuments(completion: { [roomUsersSubject] querySnapshot, error in
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                self.roomUsersSubject.onError(error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let user = Room.User(id: document.documentID, dictionary: document.data()) else {
                        continue
                    }
                    userList.append(user)
                }
                self.roomUsersSubject.onNext(userList)
                self.roomUsersSubject.onCompleted()
            }
        })
    }

    private func findRanksById(id: String) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("ranks")
        var rankList: [Room.Rank] = [Room.Rank]()

        // getDocumentsは 対象のcollectionに紐づく全てのdocumentを取得
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                self.roomRanksSubject.onError(error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let rank = Room.Rank(id: document.documentID, dictionary: document.data()) else {
                        continue
                    }
                    rankList.append(rank)
                }
                self.roomRanksSubject.onNext(rankList)
                self.roomRanksSubject.onCompleted()
            }
        })
    }
}
