//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import AlamofireImage

class FeedViewController: UIViewController {

  // MARK: Views

  private var tableView: UITableView! = {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor.clear
    tableView.register(FeedCell.self)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200
    return tableView
  }()

  // MARK: Variables

  var feedViewModel = FeedViewModel()
  
  private var disposeBag = DisposeBag()

  // MARK: Lifecycle

  override func loadView() {
    super.loadView()
    title = "Photography"
    view.backgroundColor = UIColor.lightGray
    view.addSubview(tableView)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    feedViewModel.items
      .asDriver(onErrorJustReturn: [])
      .drive(tableView.rx.items(cellIdentifier: FeedCell.reuseIdentifier, cellType: FeedCell.self)) { (index, feed, cell) in
        cell.userImageView.af_setImage(withURL: URL(string: feed.userImage)!)
        cell.userNameLabel.text = feed.userName
        cell.forumNameLabel.text = feed.forum
        cell.descriptionLabel.text = feed.description
    }.addDisposableTo(disposeBag)

    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

}
