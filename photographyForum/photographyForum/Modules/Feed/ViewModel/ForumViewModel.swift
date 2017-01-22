//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import RxSwift

class ForumViewModel {

  // MARK: Variables

  let title = Variable<String>("")
  let description = Variable<String>("")
  let logoUrl = Variable<String>("")
  let headerImageUrl = Variable<String>("")

  private var disposeBag = DisposeBag()

  // MARK: Lifecycle

  required init(service: ForumWebService = ForumWebService()) {
    service.fetch()
      .subscribe(onNext: { [weak self] forum in
        self?.title.value = forum.title
        self?.description.value = forum.description
        self?.logoUrl.value = forum.logoUrl
        self?.headerImageUrl.value = forum.headerImageUrl
      }).addDisposableTo(disposeBag)
  }
}