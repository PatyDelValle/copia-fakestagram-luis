//
//  LikeClient.swift
//  fakestagram
//
//  Created by patricia  D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class LikeUpDaterClient {
    private let client = Client()
    private let basePath = "/api/posts" //servicio
    private let post: Post
    
    init(post:Post) {
        self.post = post
    }
    
    func call()-> Post {
        if !post.liked {
            print("Liked")
            return like()
        }
        else {
            print("Dislike")
            return dislike()
        }
    }
    func like() -> Post{
        guard let postId = self.post.id else {return self.post}
        //guard let postId = post.id else {return post}
        
        client.request("POST", path: "\(basePath)/\(postId)/like", body: nil, completionHandler: onSuccessLike(response:data:), errorHandler: onError(error:))
        
        var post = self.post
        post.likesCount += 1
        post.liked = true
        return post
    }
    func dislike() -> Post {
        var post = self.post
        guard let postId = post.id else {return}
        client.request("DELETE", path: "\(basepath)/\(postId)/like", body: nil, completionHandler: onSuccess(response:data:), errorHandler: onError(error:))
        //return post.likesCount - 1

    }
    func onSuccessLike(response: HTTPResponse, data: Data?) -> Void {
        guard  response.successful() else { return }
        var post = self.post
        post.likesCount + 1
        post.liked = true
        guard let data = try? JSONEncoder().encode(post) else {return}
        //print ("Successfull like")
        NotificationCenter.default.post(name: .didLikePost, object: nil, userInfo: ["post": data as Any])
        //print ("notification posted.")
    }
   
    /*
    func onSuccessDislike(response: HTTPResponse, data: Data?) -> Void {
        guard  response.successful() else { return }
        var post = self.post
        post.likesCount + 1
        post.liked = true
        guard let data = try? JSONEncoder().encode(post) else {return}
        //print ("Successfull like")
        NotificationCenter.default.post(name: .didLikePost, object: nil, userInfo: ["post": data as Any])
        //print ("notification posted.")
    }
    */
     func onError(error:Error?) -> Void {
        guard let err = error else {return}
        print ("Error on request: \(err.localizedDescription)")
    }
}

