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
    sections = albumPhotos.map { albumPhoto -> AlbumsSection in
      let rows = albumPhoto.photo.map {
        (AlbumsRow.photo(AlbumPhotoCell.ViewModel(placeholder: nil, thumbnailUrl: $0.thumbnailUrl, imageUrl: $0.url)))
      }
      return AlbumsSection.photo(rows)
    }
  }
}
