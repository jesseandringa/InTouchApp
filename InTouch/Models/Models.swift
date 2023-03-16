//
//  Models.swift
//  InTouch
//
//  Created by jesse andringa on 3/16/23.
//

import Foundation


enum Gender{
    case male, female, other
}
struct User{
    let username: String
    let name: (first: String, last: String)
    let birthDate: Int
    let gender: Gender
    let bio: String
    let count: UserCount
    let joinDate: Date
    
}
struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}

enum UserPostType{
    case photo, video
}

///Represents a users post
public struct UserPost{
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL //either video url or full res photo
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers:[String]
    
}
struct PostLike{
    let username: String
    let postIdentifier:String
}
struct CommentLike{
    let username: String
    let commentIdentifier:String
}

struct PostComment{
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    let likes:[CommentLike]
}
