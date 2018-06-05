//
//  PhotosViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PhotosDisplayLogic: class {
  
}

class PhotosViewController: UICollectionViewController {
  typealias PhotoSelectionHandler = ((Int, Photo) -> Void)?
  var interactor: PhotosBusinessLogic?
  var handler: PhotoSelectionHandler
  let index: Int
  private let dataSource: PhotosDataSource
  
  init(index: Int, photos: [Photo], handler: PhotoSelectionHandler = nil) {
    self.index = index
    self.dataSource = PhotosDataSource(photos: photos)
    self.handler = handler
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    let interactor = PhotosInteractor()
    let presenter = PhotosPresenter()
    interactor.presenter = presenter
    presenter.viewController = self
    self.interactor = interactor
    setupView()
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
extension PhotosViewController: PhotosDisplayLogic {
  
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let row = dataSource.section(at: indexPath.section)?.row(at: indexPath.row) else {
      return UICollectionViewCell()
    }
    
    switch row {
    case .photo(let viewModel):
      let cell = collectionView.dequeueReusableCell(PhotoCell.self, at: indexPath)
      cell.update(viewModel)
      return cell
    }
  }
}

// MARK: - UICollectionViewDelegate
extension PhotosViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    handler?(indexPath.row, dataSource.photo(at: indexPath))
  }
}

// MARK: - Private Methods
private extension PhotosViewController {
  func setupView() {
    setupCollectionView()
  }
  
  func setupCollectionView() {
    collectionView?.backgroundColor = .white
    collectionView?.register(PhotoCell.self)
    collectionView?.alwaysBounceHorizontal = true
    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
      flowLayout.itemSize = CGSize(width: 150, height: 150)
      flowLayout.minimumInteritemSpacing = 25
      flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
  }
}
