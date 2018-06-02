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
    postsWorker.getPosts(success: { [weak self] posts in
      self?.presenter?.presentPosts(posts)
    }, failure: { [weak self] error in
      self?.presenter?.presentError(NetworkError.wrapped(error))
    })
  }
  
  func createPost(_ post: Post) {
    postsWorker.createPost(post, success: { [weak self] post in
      self?.presenter?.presentPost(post, creationResult: true)
    }, failure: { [weak self] _ in
      self?.presenter?.presentPost(post, creationResult: false)
    })
  }
}
