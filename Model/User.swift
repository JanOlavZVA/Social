//
//  User.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 12.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import Foundation
class Users {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var id: String?
    var isFollowing: Bool?
}

extension Users {
    static func transformUser(dict: [String: Any], key: String) -> Users {
        let users = Users()
        users.email = dict["email"] as? String
        users.profileImageUrl = dict["profileImageUrl"] as? String
        users.username = dict["username"] as? String
        users.id = key
        return users
    }
}
