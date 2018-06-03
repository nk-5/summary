//
//  DocumentSerializable.swift
//  summary
//
//  Created by 中川 慶悟 on 2018/06/03.
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

protocol DocumentSerializable {
    init?(id: String, dictionary: [String: Any])
}
