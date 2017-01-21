//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Post {
  let userName: String
  let userImageUrl: String
  let forum: String
  let description: String
  let imagesUrls: [String]
  let upVotes: Int
  
  init(json: JSON) {
    userName = json["createdBy"]["displayName"].stringValue
    userImageUrl = json["createdBy"]["avatar"]["url"].stringValue
    forum = json["forum"]["title"].stringValue
    description = json["rawContent"].stringValue
    imagesUrls = json["entities"]["images"].arrayValue.map { json in
      return json["cdnUrl"].stringValue
    }

    upVotes = json["stats"]["upVotes"].intValue
  }
}
