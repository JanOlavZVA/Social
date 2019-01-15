//
//  Api.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 12.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import Foundation
struct Api {
    static var User = UserApi()
    static var Post = PostApi()
    static var Comment = CommentApi()
    static var Post_Comment = Post_CommentApi()
    static var MyPosts = MyPostsApi()
    static var Follow = FollowApi()
    static var Feed = FeedApi()
    static var HashTag = HashTagApi()
}
