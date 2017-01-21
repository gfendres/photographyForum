//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct ForumWebService {
  func fetch() -> Observable<Forum> {
    return Observable.create { observer in
      Alamofire.request("https://api.hubchat.com/v1/forum/photography").validate().responseJSON { response in
          print(response)
          switch response.result {
          case .success(let value):
            let json = JSON(value)
            let forum = Forum(json: json["forum"])
            observer.onNext(forum)
            observer.onCompleted()
          case .failure(let error):
            observer.onError(error)
          }
        }
      return Disposables.create()
    }
  }
}
