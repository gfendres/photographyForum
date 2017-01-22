//
//  ForumViewModelSpec.swift
//  photographyForum
//
//  Created by Guilherme Endres on 22/01/17.
//  Copyright © 2017 HubChat. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SwiftyJSON

@testable import photographyForum

class ForumViewModelSpec: QuickSpec {
  override func spec() {
    describe("Forum View Model") {
      var forumViewModel: ForumViewModel!
      
      describe("init") {
        beforeEach {
          forumViewModel = ForumViewModel(service: ForumWebServiceMock())
        }
        
        it("should fetch forum information") {
          expect(forumViewModel.description.value).to(equal("some description"))
          expect(forumViewModel.title.value).to(equal("Photography"))
          expect(forumViewModel.logoUrl.value).to(equal("www.fakeurl.com"))
          expect(forumViewModel.headerImageUrl.value).to(equal("www.fakeurl.com"))
        }
      }
    }
  }
}
