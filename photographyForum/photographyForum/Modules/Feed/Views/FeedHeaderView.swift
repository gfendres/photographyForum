//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import SnapKit
import UIKit
import AlamofireImage
import RxSwift
import RxCocoa

class FeedHeaderView: UIView {

  private let margin = 20

  // MARK: Views

  private var backgroundImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()

  private var logoImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()

  private var forumTitleLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private var forumDescriptionLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private var bottomLineView: UIView! = {
    let lineView = UIView()
    lineView.backgroundColor = UIColor(white: 0.7, alpha: 1)
    return lineView
  }()

  // MARK: Variables
  
  private var disposeBag = DisposeBag()

  var forumViewModel: ForumViewModel? {
    didSet {

      forumViewModel?.headerImageUrl
        .asDriver()
        .drive(onNext: { [weak self] url in
          if let url = URL(string: url) {
            self?.backgroundImageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2))
          }
        }).addDisposableTo(disposeBag)

      forumViewModel?.logoUrl
        .asDriver()
        .drive(onNext: { [weak self] url in
          if let url = URL(string: url) {
            self?.logoImageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2))
          }
        }).addDisposableTo(disposeBag)
      
      forumViewModel?.title
        .asDriver()
        .drive(forumTitleLabel.rx.text)
        .addDisposableTo(disposeBag)
      
      forumViewModel?.description
        .asDriver()
        .drive(forumDescriptionLabel.rx.text)
        .addDisposableTo(disposeBag)

    }
  }

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(backgroundImageView)
    addSubview(logoImageView)
    addSubview(forumTitleLabel)
    addSubview(forumDescriptionLabel)
    addSubview(bottomLineView)

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private func setupConstraints() {
    backgroundImageView.snp.makeConstraints { make in
      make.trailing.top.leading.equalToSuperview()
      make.height.equalToSuperview().dividedBy(2)
    }

    logoImageView.snp.makeConstraints { make in
      make.centerY.equalTo(backgroundImageView.snp.bottom)
      make.height.equalToSuperview().dividedBy(3)
      make.width.equalTo(self.snp.height).dividedBy(3)
      make.leading.equalToSuperview().offset(margin)
    }

    forumTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(logoImageView.snp.trailing).offset(margin)
      make.top.equalTo(backgroundImageView.snp.bottom)
      make.bottom.equalTo(logoImageView)
      make.trailing.equalToSuperview().offset(-margin)
    }

    forumDescriptionLabel.snp.makeConstraints { make in
      make.leading.equalTo(logoImageView)
      make.trailing.equalToSuperview().offset(-margin)
      make.top.equalTo(logoImageView.snp.bottom).offset(margin)
    }

    bottomLineView.snp.makeConstraints { make in
      make.height.equalTo(3)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}
