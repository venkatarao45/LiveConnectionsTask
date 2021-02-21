//
//  PostsModel.swift
//  EnfecTask
//
//  Created by Venkatarao Ponnapalli  on 15/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import Foundation


struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

