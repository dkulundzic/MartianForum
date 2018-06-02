//
//  PostsInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostsBusinessLogic {
  func loadPosts()
  func createPost(_ post: Post)
}

class PostsInteractor {
  var presenter: PostsPresentationLogic?
  lazy var postsWorker = PostsWorker()
}

// MARK: - Business Logic
extension PostsInteractor: PostsBusinessLogic {
  func loadPosts() {
    presenter?.presentNetworkOperation(running: true)
    postsWorker.getPosts().then { [weak self] in
      self?.presenter?.presentPosts($0)
    }.always { [weak self] in
      self?.presenter?.presentNetworkOperation(running: false)
    }.catch { [weak self] in
      self?.presenter?.presentError(NetworkError.wrapped($0))
    }
  }
  
  func createPost(_ post: Post) {
    presenter?.presentNetworkOperation(running: true)
    postsWorker.createPost(post).then { [weak self] in
      self?.presenter?.presentPost($0, creationResult: true)
    }.always { [weak self] in
      self?.presenter?.presentNetworkOperation(running: false)
    }.catch { [weak self] _ in
      self?.presenter?.presentPost(post, creationResult: false)
    }
  }
}
