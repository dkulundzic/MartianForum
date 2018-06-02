//
//  TodosViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol TodosDisplayLogic: class {
  
}

class TodosViewController: UIViewController {
  var interactor: TodosBusinessLogic?
  var router: TodosRoutingLogic?
  private let contentView = TodosContentView.autolayoutView()
  
  init(delegate: TodosRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = TodosInteractor()
    let presenter = TodosPresenter()
    let router = TodosRouter()
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
extension TodosViewController: TodosDisplayLogic {
  
}

// MARK: - Private Methods
private extension TodosViewController {
  func setupView() {
    title = "todos_tab_bar_title".localized()
    tabBarItem.image = #imageLiteral(resourceName: "tab_bar_todos_icon")
    view.backgroundColor = .white
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
  }
}
