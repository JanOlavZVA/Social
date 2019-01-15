//
//  UserApi.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 12.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
class UserApi {
    var REF_USERS = Database.database().reference().child("users")
    
    func observeUserByUsername(username: String, completion: @escaping (UserModel) -> Void) {
        REF_USERS.queryOrdered(byChild: "username_lowercase").queryEqual(toValue: username).observeSingleEvent(of: .childAdded, with: {
            snapshot in
            print(snapshot)
            if let dict = snapshot.value as? [String: Any] {
                let userModel = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(userModel)
            }
        })
    }
    //                DataService.dataService.USER_REF.queryOrdered(byChild: "username").queryEqual(toValue: "\(mention.lowercased())").observe(.childAdded, with: { snapshot in
    
    func observeUser(withId uid: String, completion: @escaping (UserModel) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let userModel = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(userModel)
            }
        })
    }
    
    func observeCurrentUser(completion: @escaping (UserModel) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let userModel = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(userModel)
            }
        })
    }
    
    func observeUsers(completion: @escaping (UserModel) -> Void) {
        REF_USERS.observe(.childAdded, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let userModel = UserModel.transformUser(dict: dict, key: snapshot.key)
                completion(userModel)
            }
        })
    }
    
    func queryUsers(withText text: String, completion: @escaping (UserModel) -> Void) {
        REF_USERS.queryOrdered(byChild: "username_lowercase").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: {
            snapshot in
            snapshot.children.forEach({ (s) in
                let child = s as! DataSnapshot
                if let dict = child.value as? [String: Any] {
                    let userModel = UserModel.transformUser(dict: dict, key: child.key)
                    completion(userModel)
                }
            })
        })
    }
    
    var CURRENT_USER: Firebase.User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        
        return nil
    }
    
    var REF_CURRENT_USER: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        
        return REF_USERS.child(currentUser.uid)
    }
}
