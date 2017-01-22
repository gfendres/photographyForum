//
//  ForumSpec.swift
//  photographyForum
//
//  Created by Guilherme Endres on 22/01/17.
//  Copyright © 2017 HubChat. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import photographyForum

class ForumSpec: QuickSpec {
  
  override func spec() {
    describe("Forum") {
      var forum: Forum!
      
      describe("init") {
        beforeEach {
          forum = Forum(json: ForumJsonMock.validJson)
        }
        
        it("should set variables properly") {
          expect(forum.description).to(equal("some description"))
          expect(forum.title).to(equal("Photography"))
          expect(forum.logoUrl).to(equal("www.fakeurl.com"))
          expect(forum.headerImageUrl).to(equal("www.fakeurl.com"))
        }
      }
    }
  }
  
}
