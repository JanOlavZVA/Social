//
//  FeedApi.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 12.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import Foundation
import FirebaseDatabase
class FeedApi {
    var REF_FEED = Database.database().reference().child("feed")
    
    func observeFeed(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childAdded, with: {
            snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post) in
                completion(post)
            })
        })
    }
    
    func observeFeedRemoved(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childRemoved, with: {
            snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post) in
                completion(post)
            })
        })
    }
}
