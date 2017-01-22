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

  private var headerView: FeedHeaderView! = {
    let headerView = FeedHeaderView(frame: .zero)
    return headerView
  }()

  private var tableView: UITableView! = {
    let tableView = UITableView()
    tableView.register(FeedCell.self)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 500
    tableView.allowsSelection = false
    tableView.isHidden = true
    return tableView
  }()

  // MARK: Variables

  private var feedViewModel = FeedViewModel()
  private var disposeBag = DisposeBag()

  // MARK: Lifecycle

  override func loadView() {
    super.loadView()
    title = "hubchat"
    view.backgroundColor = UIColor.white
    view.addSubview(tableView)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableHeaderView = headerView
    headerView.forumViewModel = ForumViewModel()
    setupConstraints()
    setupObservables()
  }

  // MARK: Private

  private func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    headerView.snp.makeConstraints { make in
      make.height.equalTo(300)
      make.leading.top.width.equalToSuperview()
    }
  }

  private func setupObservables() {
    feedViewModel
      .items
      .asDriver(onErrorJustReturn: [])
      .map { $0.count == 0 }
      .drive(tableView.rx.isHidden)
      .addDisposableTo(disposeBag)

    feedViewModel.items
      .asDriver(onErrorJustReturn: [])
      .drive(tableView.rx.items(cellIdentifier: FeedCell.reuseIdentifier, cellType: FeedCell.self)) { (index, post, cell) in
        cell.viewModel = PostViewModel(post: post)
      }.addDisposableTo(disposeBag)

  }
}
