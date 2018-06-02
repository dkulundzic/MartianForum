//
//  PostDetailsPresenter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostDetailsPresentationLogic {
  func presentComments(_ comments: [Comment])
  func presentError(_ error: MartianError)
}

class PostDetailsPresenter {
  weak var viewController: PostDetailsDisplayLogic?
}

// MARK: - Presentation Logic
extension PostDetailsPresenter: PostDetailsPresentationLogic {
  func presentComments(_ comments: [Comment]) {
    viewController?.displayComments(comments)
  }
  
  func presentError(_ error: MartianError) {
    viewController?.displayError(title: error.localisedTitle, message: error.localizedDescription)
  }
}
