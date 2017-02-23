//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Forum {
  let title: String
  let description: String
  let logoUrl: String
  let headerImageUrl: String

  init(json: JSON) {
    title = json["title"].stringValue
    description = json["description"].stringValue
    logoUrl = json["image"]["url"].stringValue
    headerImageUrl = json["headerImage"]["url"].stringValue
  }
}