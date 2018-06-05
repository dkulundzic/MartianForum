//
//  AlbumPhotosWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 04/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class AlbumPhotosWorker {
  private let albumCount = 3
  private let photosPerAlbumCount = 10
  
  func retrieveAlbumsAndPhotos() -> Promise<[AlbumPhoto]> {
    return all(RestfulNetworkService<Album>().getAll(), RestfulNetworkService<Photo>().getAll()).then { albums, photos -> [AlbumPhoto] in
      return Array(albums[0...self.albumCount]).compactMap { album in
        let albumPhotos = photos.filter { $0.albumId == album.id }[0...self.photosPerAlbumCount]
        return AlbumPhoto(album: album, photos: Array(albumPhotos))
      }
    }
  }
}
