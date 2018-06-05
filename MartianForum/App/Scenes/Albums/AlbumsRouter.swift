//
//  AlbumsRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol AlbumsRoutingLogic {
  func navigateToPhoto(photo: Photo)
  
}

protocol AlbumsRouterDelegate: class { }

class AlbumsRouter {
  weak var viewController: AlbumsViewController?
  weak var delegate: AlbumsRouterDelegate?
}

// MARK: - Routing Logic
extension AlbumsRouter: AlbumsRoutingLogic {
  func navigateToPhoto(photo: Photo) {
    let photoViewController = PhotoViewController(photo: photo, delegate: self)
    let navigationController = UINavigationController(rootViewController: photoViewController)
    navigationController.navigationBar.barTintColor = .black
    navigationController.navigationBar.isTranslucent = false
    viewController?.present(navigationController, animated: true, completion: nil)
  }
}

// MARK: - PhotoRouterDelegate
extension AlbumsRouter: PhotoRouterDelegate {
  func photoRouterDelegateUnwindBack() {
    viewController?.dismiss(animated: true, completion: nil)
  }  
}
