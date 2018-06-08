//
//  TodosInputHeader.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 07/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class TodosInputHeader: UICollectionReusableView {
  struct ViewModel {
    let enteredText: String?
  }
  
  private let textField = UITextField.autolayoutView()
  var inputHandler: ((String?) -> Void)?
  var returnHandler: ((UITextField) -> Void)?
  
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

extension TodosInputHeader {
  func update(_ viewModel: ViewModel) {
    textField.text = viewModel.enteredText
  }
}

extension TodosInputHeader: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    returnHandler?(textField)
    return true
  }
}

private extension TodosInputHeader {
  @objc func textFieldChangedText(_ sender: UITextField) {
    Logger.debug("")
    inputHandler?(sender.text)
  }
}

private extension TodosInputHeader {
  func setupViews() {
    backgroundColor = .white
    layer.cornerRadius = 2
    setupTextField()
  }
  
  func setupTextField() {
    addSubview(textField)
    textField.backgroundColor = .martianLightGray
    textField.borderStyle = .roundedRect
    textField.placeholder = "todos_input_placeholder".localized()
    textField.returnKeyType = .done
    textField.font = .preferredFont(forTextStyle: .body)
    textField.tintColor = .martianRed
    textField.textColor = .black
    textField.layer.cornerRadius = 2
    textField.delegate = self
    textField.addTarget(self, action: #selector(textFieldChangedText(_:)), for: .editingChanged)
    textField.snp.makeConstraints {
      $0.leading.trailing.top.bottom.equalToSuperview().inset(10)
    }
  }
}
