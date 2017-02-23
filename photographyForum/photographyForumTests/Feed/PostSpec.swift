//
//  PostSpec.swift
//  photographyForum
//
//  Created by Guilherme Endres on 21/01/17.
//  Copyright © 2017 HubChat. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SwiftyJSON

@testable import photographyForum

class PostSpec: QuickSpec {

  override func spec() {
    describe("Post") {
      var post: Post!
      
      describe("init") {
        beforeEach {
          post = Post(json: FeedJsonMock.validJson)
        }
        
        it("should set variables properly") {
          expect(post.userName).to(equal("username"))
          expect(post.forum).to(equal("Photography"))
          expect(post.description).to(equal("some description"))
          expect(post.imagesUrls.first).to(equal("www.fakeimageurl.com"))
          expect(post.upVotes).to(equal(10))
          expect(post.userImageUrl).toNot(beNil())
        }
      }
    }
  }
    
}
