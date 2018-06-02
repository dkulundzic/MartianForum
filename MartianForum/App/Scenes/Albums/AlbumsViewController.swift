//
//  AlbumsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol AlbumsDisplayLogic: class {
  
}

class AlbumsViewController: UIViewController {
  var interactor: AlbumsBusinessLogic?
  var router: AlbumsRoutingLogic?
  private let contentView = AlbumsContentView.autolayoutView()
  
  init(delegate: AlbumsRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = AlbumsInteractor()
    let presenter = AlbumsPresenter()
    let router = AlbumsRouter()
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
extension AlbumsViewController: AlbumsDisplayLogic {
  
}

// MARK: - Private Methods
private extension AlbumsViewController {
  func setupView() {
    title = "albums_tab_bar_title".localized()
    tabBarItem.image = #imageLiteral(resourceName: "tab_bar_albums_icon")
    view.backgroundColor = .white
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
  }
}
