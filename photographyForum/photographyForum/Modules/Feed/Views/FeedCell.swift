//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import AlamofireImage

class FeedCell: UITableViewCell {

  private let margin = 20
  private var collectionHeightConstraint: Constraint?

  // MARK: Views

  var userImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var forumNameLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var userNameLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var descriptionLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  var postImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var imagesCollectionView: UICollectionView! = {

    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(ImageCell.self)
    collectionView.backgroundColor = UIColor.clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  var headerView: UIView! = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.clear
    return view
  }()

  var upVotesView: UpVotesView! = {
    let view = UpVotesView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.clear
    return view
  }()

  // MARK: Variables

  private var imagesUrl = Variable<[String]>([])

  var viewModel: PostViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }

      if let url = viewModel.userImageUrl {
        userImageView.af_setImage(
          withURL: url,
          placeholderImage: #imageLiteral(resourceName: "userPlaceholder"),
          filter: CircleFilter(),
          imageTransition: .crossDissolve(0.2))
      } else {
        userImageView.image = #imageLiteral(resourceName: "userPlaceholder")
      }

      userNameLabel.text = viewModel.userName
      forumNameLabel.text = viewModel.forum
      descriptionLabel.text = viewModel.description
      upVotesView.upVotes = viewModel.upVotes
      imagesUrl.value = viewModel.imagesUrls
    }
  }
  private let disposeBag = DisposeBag()

  // MARK: Lifecycle

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    headerView.addSubview(userNameLabel)
    headerView.addSubview(userImageView)
    headerView.addSubview(forumNameLabel)

    addSubview(headerView)
    addSubview(descriptionLabel)
    addSubview(imagesCollectionView)
    addSubview(upVotesView)

    setupConstraints()
    setupObservables()

    imagesCollectionView.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    userImageView.image = nil
  }

  // MARK: Private

  private func isEmptyImages(_ images: [String]) -> Bool {
    return images.isEmpty
  }

  private func setupConstraints() {
    headerView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalTo(80).priority(250)
    }

    userImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(margin)
    }

    forumNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(userImageView.snp.trailing).offset(10)
      make.top.equalTo(userImageView.snp.top)
      make.trailing.equalToSuperview().offset(-margin)
      make.bottom.equalTo(userImageView.snp.centerY)
    }

    userNameLabel.snp.makeConstraints { make in
      make.top.equalTo(forumNameLabel.snp.bottom)
      make.leading.trailing.equalTo(forumNameLabel)
      make.bottom.equalTo(userImageView)
    }

    imagesCollectionView.snp.makeConstraints { make in
      make.top.equalTo(headerView.snp.bottom).priority(250)
      self.collectionHeightConstraint = make.height.equalTo(snp.width).constraint
      make.height.equalTo(0).priority(10)
      make.trailing.leading.equalToSuperview()
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(imagesCollectionView.snp.bottom).offset(10)
      make.leading.equalTo(upVotesView.snp.trailing)
      make.trailing.equalToSuperview().offset(-margin)
      make.bottom.lessThanOrEqualToSuperview().offset(-margin)

    }

    upVotesView.snp.makeConstraints { make in
      make.top.equalTo(imagesCollectionView.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(margin)
      make.height.equalTo(30)
      make.width.equalTo(60)
      make.bottom.lessThanOrEqualToSuperview().offset(-margin)
    }
  }

  private func setupObservables() {
    imagesUrl
      .asDriver()
      .skip(1)
      .map(isEmptyImages)
      .drive(onNext: { isEmpty in
        if isEmpty {
          self.collectionHeightConstraint?.deactivate()
        } else {
          self.collectionHeightConstraint?.activate()
        }
      }).addDisposableTo(disposeBag)

    imagesUrl
      .asDriver()
      .drive(imagesCollectionView.rx.items(cellIdentifier: ImageCell.reuseIdentifier, cellType: ImageCell.self)) { (index, imageUrl, cell) in
        guard let url = URL(string: imageUrl) else {
          cell.imageView.image = #imageLiteral(resourceName: "imagePlaceholder")
          return
        }
        cell.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), imageTransition: .crossDissolve(0.2))
      }.addDisposableTo(disposeBag)
  }
}

extension FeedCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
  }
}
