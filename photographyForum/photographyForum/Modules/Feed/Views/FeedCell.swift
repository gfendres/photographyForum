//
// Created by Guilherme Endres on 19/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FeedCell: UITableViewCell {

  private let margin = 20

  // MARK: Views

  var userImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  var forumNameLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12)
    return label
  }()

  var userNameLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()

  var descriptionLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.numberOfLines = 0
    return label
  }()

  var postImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  // MARK: Lifecycle

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    addSubview(userImageView)
    addSubview(forumNameLabel)
    addSubview(userNameLabel)
    addSubview(descriptionLabel)

    userImageView.snp.makeConstraints { make in
      make.leading.top.equalTo(margin)
      make.height.width.equalTo(30)
    }

    forumNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(userImageView.snp.trailing).offset(10)
      make.top.equalTo(margin)
      make.trailing.equalToSuperview().offset(-margin)
      make.bottom.equalTo(userImageView.snp.centerY)
    }

    userNameLabel.snp.makeConstraints { make in
      make.top.equalTo(forumNameLabel.snp.bottom)
      make.leading.trailing.equalTo(forumNameLabel)
      make.bottom.equalTo(userImageView)
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(userImageView.snp.bottom).offset(20)
      make.leading.equalTo(userImageView)
      make.trailing.equalToSuperview().offset(-margin)
      make.bottom.equalToSuperview().offset(-margin)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
