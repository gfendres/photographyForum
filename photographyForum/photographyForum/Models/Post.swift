//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Post {
  var userName: String
  var userImage: String
  var forum: String
  var description: String
  var images: [UIImage] = []
  
  init(json: JSON) {
    userName = json["createdBy"]["displayName"].stringValue
    userImage = json["createdBy"]["avatar"]["url"].stringValue
    forum = json["forum"]["title"].stringValue
    description = json["rawContent"].stringValue
  }
}
