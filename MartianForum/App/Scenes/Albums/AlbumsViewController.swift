//
//  AlbumsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol AlbumsDisplayLogic: class {
  func displayAlbumsAndPhotos(_ albumPhotos: [AlbumPhoto])
  func displayError(title: String?, message: String?)
}

class AlbumsViewController: UICollectionViewController {
  var interactor: AlbumsBusinessLogic?
  var router: AlbumsRoutingLogic?
  private let contentView = AlbumsContentView.autolayoutView()
  private let dataSource = AlbumsDataSource()
  
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
    interactor.loadAlbumsAndPhotos()
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
  func displayAlbumsAndPhotos(_ albumPhotos: [AlbumPhoto]) {
    
  }
  
  func displayError(title: String?, message: String?) {
    
  }
}

// MARK: - Display Logic
extension AlbumsViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
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
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
