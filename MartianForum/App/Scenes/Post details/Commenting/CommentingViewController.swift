//
//  CommentingViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol CommentingDisplayLogic: class {
  
}

class CommentingViewController: UIViewController {
  var interactor: CommentingBusinessLogic?
  var router: CommentingRoutingLogic?
  private let contentView = CommentingContentView.autolayoutView()
  
  init(delegate: CommentingRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = CommentingInteractor()
    let presenter = CommentingPresenter()
    let router = CommentingRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    // call update constraints method
  }
}

// MARK: - Display Logic
extension CommentingViewController: CommentingDisplayLogic {
  
}

// MARK: - Private Methods
private extension CommentingViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
