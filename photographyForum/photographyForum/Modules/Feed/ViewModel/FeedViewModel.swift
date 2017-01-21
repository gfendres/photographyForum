//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FeedViewModel {
  var items = FeedWebService().fetch()
}
