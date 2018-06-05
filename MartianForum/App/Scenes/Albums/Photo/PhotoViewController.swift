//
//  PhotoViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
  var router: PhotoRoutingLogic?
  private let contentView = PhotoContentView.autolayoutView()
  private let photo: Photo
  
  init(photo: Photo, delegate: PhotoRouterDelegate?) {
    self.photo = photo
    super.init(nibName: nil, bundle: nil)
    let router = PhotoRouter()
    router.viewController = self
    router.delegate = delegate
    self.router = router
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Actions
private extension PhotoViewController {
  @objc func closeButtonTapped() {
    router?.unwindBack()
  }
}

// MARK: - Private Methods
private extension PhotoViewController {
  func setupView() {
    view.backgroundColor = .black
    setupNavigationBar()
    setupContentView(photo: photo)
  }
  
  func setupNavigationBar() {
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.leftBarButtonItem = UIBarButtonItem.dismiss(target: self, selector: #selector(closeButtonTapped))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  func setupContentView(photo: Photo) {
    view.addSubview(contentView)
    contentView.update(photo)
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
