//
//  CommentingInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol CommentingBusinessLogic {
  func postComment(_ comment: String, for post: Post)
}

class CommentingInteractor {
  var presenter: CommentingPresentationLogic?
}

// MARK: - Business Logic
extension CommentingInteractor: CommentingBusinessLogic {
  func postComment(_ comment: String, for post: Post) {
    let comment = Comment(id: -1, postId: post.id, name: "Test", email: "test@gmail.com", body: comment)
    presenter?.presentNetworkOperation(running: true)
    RestfulNetworkService<Comment>().post(model: comment)
      .delay(1)
      .then { [weak self] comment -> Void in
        self?.presenter?.presentSuccessfulCommentPost(comment: comment)
      }.always { [weak self] in
        self?.presenter?.presentNetworkOperation(running: false)
      }.catch { [weak self] error in
        self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
}
