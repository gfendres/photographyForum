//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct FeedWebService {
  func fetch() -> Observable<[Post]> {
    return Observable.create { observer in
      Alamofire.request("https://api.hubchat.com/v1/forum/photography/post").validate().responseJSON { response in
        print(response)
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          let feed = json["posts"].arrayValue.map(Post.init)
          observer.onNext(feed)
          observer.onCompleted()
        case .failure(let error):
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
