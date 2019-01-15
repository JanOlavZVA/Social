//
//  UserModel.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 13.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//


import Foundation
class UserModel {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var id: String?
    var isFollowing: Bool?
}

extension UserModel {
    static func transformUser(dict: [String: Any], key: String) -> UserModel {
        let userModel = UserModel()
        userModel.email = dict["email"] as? String
        userModel.profileImageUrl = dict["profileImageUrl"] as? String
        userModel.username = dict["username"] as? String
        userModel.id = key
        return userModel
    }
}
