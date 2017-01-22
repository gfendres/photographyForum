//
//  FeedServiceMock.swift
//  photographyForum
//
//  Created by Guilherme Endres on 21/01/17.
//  Copyright © 2017 HubChat. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FeedJsonMock {
  static let validJson: JSON =
    ["createdBy":
      ["displayName": "username",
       "avatar": ["url": "www.fakeurl.com"]
      ],
     "forum": ["title": "Photography"],
     "rawContent": "some description",
     "entities":
      ["images":
        [
          ["cdnUrl": "www.fakeimageurl.com"]
        ]
      ],
     "stats": ["upVotes": 10]
  ]
  
  static let invalidJson: JSON =
    ["createdBy":
      ["displayName": "username",
       "avatar": ["url": ""]
      ],
     "forum": ["title": "Photography"],
     "rawContent": "some description",
     "entities":
      ["images":
        [
          ["cdnUrl": "www.fakeimageurl.com"]
        ]
      ],
     "stats": ["upVotes": 10]
  ]
}
