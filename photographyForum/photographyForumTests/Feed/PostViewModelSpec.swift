//
//  PostViewModelSpec.swift
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

class PostViewModelSpec: QuickSpec {
  
  override func spec() {
    describe("Post view model") {
      var postViewModel: PostViewModel!
  
      describe("init with post") {
        context("json with url") {
          beforeEach {
            postViewModel = PostViewModel(post: Post(json: FeedJsonMock.validJson))
          }
          
          it("should set the variables") {
            expect(postViewModel.userName).to(equal("username"))
            expect(postViewModel.forum).to(equal("Photography"))
            expect(postViewModel.description).to(equal("some description"))
            expect(postViewModel.imagesUrls.first).to(equal("www.fakeimageurl.com"))
            expect(postViewModel.upVotes).to(equal(10))
            expect(postViewModel.userImageUrl).toNot(beNil())
          }
        }

        context("json without url") {
          beforeEach {
            postViewModel = PostViewModel(post: Post(json: FeedJsonMock.invalidJson))
          }
          
          it("should set the variables") {
            expect(postViewModel.userName).to(equal("username"))
            expect(postViewModel.forum).to(equal("Photography"))
            expect(postViewModel.description).to(equal("some description"))
            expect(postViewModel.imagesUrls.first).to(equal("www.fakeimageurl.com"))
            expect(postViewModel.upVotes).to(equal(10))
            expect(postViewModel.userImageUrl).to(beNil())
          }
        }

      }
    }
  }
  
}
