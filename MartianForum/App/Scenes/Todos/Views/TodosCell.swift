//
//  TodosCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 06/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class TodosCell: UICollectionViewCell {
  struct ViewModel {
    let title: String
    let completed: Bool
  }
  
  private let actionButton = UIButton(type: .custom).autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  var handler: ((TodosCell) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    if layer.shadowPath == nil {
      dropShadow(path: UIBezierPath(rect: bounds))
    }
  }
}

extension TodosCell {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
    actionButton.isSelected = viewModel.completed
    updateStyling(when: viewModel.completed)
  }
}

private extension TodosCell {
  @objc func actionButtonTapped() {
    handler?(self)
  }
}

private extension TodosCell {
  func setupViews() {
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 2
    setupActionButton()
    setupTitleLabel()
  }
  
  func setupActionButton() {
    contentView.addSubview(actionButton)
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    actionButton.tintColor = .martianGray
    actionButton.setImage(#imageLiteral(resourceName: "checkbox-unselected"), for: .normal)
    actionButton.setImage(#imageLiteral(resourceName: "checkbox-selected"), for: .selected)
    actionButton.setContentHuggingPriority(.required, for: .horizontal)
    actionButton.snp.makeConstraints {
      $0.leading.top.equalToSuperview().inset(16)
      $0.width.equalTo(30)
      $0.width.equalTo(actionButton.snp.height)
    }
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.font = .preferredFont(forTextStyle: .body)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.textColor = .black
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(actionButton.snp.trailing).offset(16)
      $0.top.bottom.trailing.equalToSuperview().inset(16)
    }
  }
  
  func updateStyling(when completed: Bool) {
    titleLabel.textColor = completed ? .martianGray: .black
    contentView.backgroundColor = completed ? .martianLightGray: .white
  }
}
