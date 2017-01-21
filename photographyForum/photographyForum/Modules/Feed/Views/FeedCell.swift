//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

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

  // MARK: Variables

  var imagesUrl = Variable<[String]>([])
  private let disposeBag = DisposeBag()

  // MARK: Lifecycle

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    headerView.addSubview(userImageView)
    headerView.addSubview(forumNameLabel)
    headerView.addSubview(userNameLabel)

    addSubview(headerView)
    addSubview(descriptionLabel)
    addSubview(imagesCollectionView)

    headerView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalTo(80).priorityLow()
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
      make.top.equalTo(headerView.snp.bottom).offset(20).priorityLow()
      self.collectionHeightConstraint = make.height.equalTo(snp.width).constraint
      make.trailing.leading.equalToSuperview()
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(imagesCollectionView.snp.bottom).offset(20)
      make.leading.equalTo(userImageView)
      make.trailing.bottom.equalToSuperview().offset(-margin)
    }

    imagesCollectionView.delegate = self

    imagesUrl
      .asObservable()
      .map(isEmptyImages)
      .subscribe(onNext: { isEmpty in
        if isEmpty {
          self.collectionHeightConstraint?.deactivate()
        }
      }).addDisposableTo(disposeBag)

    imagesUrl
      .asDriver()
      .drive(imagesCollectionView.rx.items(cellIdentifier: ImageCell.reuseIdentifier, cellType: ImageCell.self)) { (index, imageUrl, cell) in
        guard let url = URL(string: imageUrl) else {
          fatalError()
        }
        cell.imageView.af_setImage(withURL: url, placeholderImage: UIImage(), imageTransition: .crossDissolve(0.2))
      }.addDisposableTo(disposeBag)
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
    return images.filter { url in
      return url.isEmpty
    }.count > 0
  }
}

extension FeedCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
  }
}
