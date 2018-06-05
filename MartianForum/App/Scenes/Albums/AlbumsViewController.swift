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
  private let dataSource = AlbumsDataSource()
  
  init(delegate: AlbumsRouterDelegate?) {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
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
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { _ in
      self.collectionView?.collectionViewLayout.invalidateLayout()
    }, completion: nil)
  }
}

// MARK: - Display Logic
extension AlbumsViewController: AlbumsDisplayLogic {
  func displayAlbumsAndPhotos(_ albumPhotos: [AlbumPhoto]) {
    dataSource.addAlbumPhotos(albumPhotos)
    collectionView?.reloadData()
  }
  
  func displayError(title: String?, message: String?) {
    
  }
}

// MARK: - UICollectionViewDataSource
extension AlbumsViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let row = dataSource.row(at: indexPath) else {
      return UICollectionViewCell()
    }
    
    switch row {
    case .photo(let photosViewController):
      let cell = collectionView.dequeueReusableCell(AlbumCell.self, at: indexPath)
      cell.constrain(viewController: photosViewController)
      photosViewController.handler = { [weak self] index, photo in
        collectionView.selectItem(at: IndexPath(item: index, section: indexPath.section), animated: true, scrollPosition: [])
        self?.router?.navigateToPhoto(photo: photo)
      }
      return cell
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let section = dataSource.section(at: indexPath.section), kind == UICollectionElementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    switch section {
    case .photo(let viewModel, _):
      let header: AlbumHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, forIndexPath: indexPath)
      header.update(viewModel)
      return header
    }
  }
}

// MARK: - UICollectionViewDelegate
extension AlbumsViewController {
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let row = dataSource.row(at: indexPath) else {
      return
    }
    
    if case AlbumsRow.photo(let photosViewController) = row {
      addChildViewController(photosViewController)
      photosViewController.didMove(toParentViewController: self)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let row = dataSource.row(at: indexPath) else {
      return
    }
    
    if case AlbumsRow.photo(let photosViewController) = row {
      photosViewController.removeFromParentViewController()
      photosViewController.didMove(toParentViewController: nil)
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 170)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}

// MARK: - Private Methods
private extension AlbumsViewController {
  func setupView() {
    title = "albums_tab_bar_title".localized()
    tabBarItem.image = #imageLiteral(resourceName: "tab_bar_albums_icon")
    collectionView?.backgroundColor = .martianLightGray
    clearsSelectionOnViewWillAppear = true
    setupContentView()
  }
  
  func setupContentView() {
    collectionView?.alwaysBounceVertical = true
    collectionView?.register(AlbumCell.self)
    collectionView?.registerSupplementaryView(AlbumHeaderReusableView.self, kind: UICollectionElementKindSectionHeader)
  }
}
