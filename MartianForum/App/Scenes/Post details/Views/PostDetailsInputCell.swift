//
//  PostDetailsInputCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostDetailsInputCell: UITableViewCell {
  let textField = UITextField.autolayoutView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension PostDetailsInputCell {
  func setupViews() {
    selectionStyle = .none
    contentView.backgroundColor = .martianLightGray
    setupTextField()
  }
  func setupTextField() {
    contentView.addSubview(textField)
    textField.borderStyle = .roundedRect
    textField.textColor = .martianDarkGray
    textField.font = .preferredFont(forTextStyle: .body)
    textField.snp.makeConstraints {
      $0.leading.trailing.top.bottom.equalToSuperview().inset(16)
    }
  }
}
