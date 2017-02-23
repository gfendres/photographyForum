//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation

class PostViewModel {

  let userName: String
  let userImageUrl: URL?
  let forum: String
  let description: String
  let imagesUrls: [String]
  let upVotes: Int

  required init(post: Post) {
    userName = post.userName
    if let url = URL(string:  post.userImageUrl) {
      userImageUrl = url
    } else {
      userImageUrl = nil
    }
    forum = post.forum
    description = post.description
    imagesUrls = post.imagesUrls
    upVotes = post.upVotes
  }
}