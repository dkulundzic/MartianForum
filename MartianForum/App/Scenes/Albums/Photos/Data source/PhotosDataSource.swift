//
//  PhotosDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PhotosDataSource: DataSourceProtocol {
  private(set) var sections = [PhotosSection]()
  private let photos: [Photo]
  
  init(photos: [Photo]) {
    self.photos = photos
    buildSections()
  }
}

extension PhotosDataSource {
  func photo(at indexPath: IndexPath) -> Photo {
    return photos[indexPath.row]
  }
}

private extension PhotosDataSource {
  func buildSections() {
    let rows = photos.map {
      PhotosRow.photo(PhotoCell.ViewModel(placeholder: nil, thumbnailUrl: $0.thumbnailUrl, imageUrl: $0.url))      
    }
    sections.append(.photos(rows))
  }
}
