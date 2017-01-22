//
//  ForumServiceMock.swift
//  photographyForum
//
//  Created by Guilherme Endres on 22/01/17.
//  Copyright © 2017 HubChat. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

@testable import photographyForum

class ForumWebServiceMock: ForumWebService {

  override func fetch() -> Observable<Forum> {
    return Observable.just(Forum(json: ForumJsonMock.validJson))
  }

}

struct ForumJsonMock {
  static let validJson: JSON =
    [
      "title": "Photography",
      "description": "some description",
      "image": ["url": "www.fakeurl.com"],
      "headerImage": ["url": "www.fakeurl.com"]
    ]

}
