//
//  RankViewModel.swift
//  summary
//
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import FirebaseFirestore
import RxSwift

class RankViewModel {
    private let rankSubject: PublishSubject = PublishSubject<Rank>()
    private let rankUsersSubject: PublishSubject = PublishSubject<[Rank.User]>()
    private let rankItemsSubject: PublishSubject = PublishSubject<[Rank.Item]>()
    
    var rank: Observable<Rank> { return rankSubject }
    
    public func findRankById(id: String) {
//        let observable = Observable.combineLatest(rankUsersSubject, rankItemsSubject, resultSelector: {
//            users, items in
//            Rank.init(id: id, users: users, admin: <#T##String#>, category: <#T##String#>, items: <#T##[Rank.Item]#>, deadline: <#T##Timestamp#>, icon: <#T##String?#>, permission: <#T##Int#>, minimumRequirement: <#T##Int#>, resultScope: <#T##Bool#>, scope: <#T##Bool#>, state: <#T##RankState#>, type: <#T##Int#>, comments: <#T##[String : String?]#>)
//        })
        
//        observable.subscribe(onNext: { rank in
//            self.rankSubject.onNext(rank)
//        }).disposed(by: disposeBag)
//
//        findUsersById(id: id)
//        findItemsById(id: id)
    }
    
    private func findUsersById(id: String) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("ranks").document(id).collection("users")
        var userList: [Rank.User] = [Rank.User]()
        
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                self.rankUsersSubject.onError(error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let user = Rank.User(dictionary: document.data()) else {
                        continue
                    }
                    userList.append(user)
                }
                self.rankUsersSubject.onNext(userList)
                self.rankUsersSubject.onCompleted()
            }
        })
    }
    
    private func findItemsById(id: String) {
        let firestore = Firestore.firestore()
        let ref = firestore.collection("rooms").document(id).collection("items")
        var itemList: [Rank.Item] = [Rank.Item]()
        
        ref.getDocuments(completion: { querySnapshot, error in
            if let error = error {
                print("\(error)")
                self.rankItemsSubject.onError(error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID)")
                    print("\(document.data())")
                    guard let item = Rank.Item(dictionary: document.data()) else {
                        continue
                    }
                    itemList.append(item)
                }
                self.rankItemsSubject.onNext(itemList)
                self.rankItemsSubject.onCompleted()
            }
        })
    }

}
