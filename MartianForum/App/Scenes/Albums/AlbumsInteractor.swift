//
//  AlbumsInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol AlbumsBusinessLogic {
  func loadAlbumsAndPhotos()
}

class AlbumsInteractor {
  var presenter: AlbumsPresentationLogic?
  lazy var worker = AlbumPhotosWorker()
}

// MARK: - Business Logic
extension AlbumsInteractor: AlbumsBusinessLogic {
  func loadAlbumsAndPhotos() {
    worker.retrieveAlbumsAndPhotos().then { [weak self] albumsAndPhotos in
      self?.presenter?.presentAlbumsAndPhotos(albumsAndPhotos)
    }.catch { [weak self] error in
        self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
}
