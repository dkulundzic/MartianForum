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
  }
}
