//
//  PostsPresenter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostsPresentationLogic {
  func presentPosts(_ posts: [PostUser])
  func presentPost(_ post: Post, creationResult: Bool)
  func presentError(_ error: MartianError)
}

class PostsPresenter {
  weak var viewController: PostsDisplayLogic?
}

// MARK: - Presentation Logic
extension PostsPresenter: PostsPresentationLogic {
  func presentPosts(_ posts: [PostUser]) {
    viewController?.displayPosts(posts)
  }
  
  func presentPost(_ post: Post, creationResult: Bool) {
    
  }
  
  func presentError(_ error: MartianError) {
    viewController?.displayError(title: error.localisedTitle, message: error.localizedDescription)
  }
}
