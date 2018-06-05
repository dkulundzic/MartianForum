//
//  AlbumsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class AlbumsDataSource: DataSourceProtocol {
  var sections = [AlbumsSection]()
  private var albumPhotos = [AlbumPhoto]()
  
  init() {
    buildSections()
  }
}

extension AlbumsDataSource {
  func addAlbumPhotos(_ albumPhotos: [AlbumPhoto]) {
    self.albumPhotos = albumPhotos
    buildSections()
  }
}

private extension AlbumsDataSource {
  func buildSections() {
    sections = albumPhotos.enumerated().map {
      let rows: [AlbumsRow] = [.photo(PhotosViewController(index: $0.offset, photos: $0.element.photos))]
      return AlbumsSection.photo($0.element.album.title, rows)
    }
  }
}
