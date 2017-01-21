//
// Created by Guilherme Endres on 21/01/17.
// Copyright (c) 2017 HubChat. All rights reserved.
//

import Foundation
import SnapKit

class UpVotesView: UIView {

  // MARK: Views

  private var heartImageView: UIImageView! = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = #imageLiteral(resourceName: "like")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private var heartCountLabel: UILabel! = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: Variables

  var upVotes: Int = 0 {
    didSet {
      heartCountLabel.text = String(upVotes)
    }
  }

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(heartImageView)
    addSubview(heartCountLabel)

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private func setupConstraints() {
    heartImageView.snp.makeConstraints { make in
      make.size.equalTo(30)
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview()
    }

    heartCountLabel.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
      make.leading.equalTo(heartImageView.snp.trailing).offset(10)
    }
  }
}
