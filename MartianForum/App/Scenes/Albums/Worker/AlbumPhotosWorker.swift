//
//  AlbumPhotosWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 04/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class AlbumPhotosWorker {
  func retrieveAlbumsAndPhotos() -> Promise<[AlbumPhoto]> {
    return all(RestfulNetworkService<Album>().getAll(), RestfulNetworkService<Photo>().getAll()).then { albums, photos -> [AlbumPhoto] in
      return albums.compactMap { album in
        let albumPhotos = photos.filter { $0.albumId == album.id }
        return AlbumPhoto(album: album, photos: albumPhotos)
      }
    }
  }
}
