//
//  AlbumsPresenter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol AlbumsPresentationLogic {
  func presentAlbumsAndPhotos(_ albumPhotos: [AlbumPhoto])
  func presentError(_ error: MartianError)
}

class AlbumsPresenter {
  weak var viewController: AlbumsDisplayLogic?
}

// MARK: - Presentation Logic
extension AlbumsPresenter: AlbumsPresentationLogic {
  func presentAlbumsAndPhotos(_ albumPhotos: [AlbumPhoto]) {
    viewController?.displayAlbumsAndPhotos(albumPhotos)
  }
  
  func presentError(_ error: MartianError) {
    viewController?.displayError(title: error.localisedTitle, message: error.localizedDescription)
  }
}
