//
//  CommentingPresenter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol CommentingPresentationLogic {
  func presentSuccessfulCommentPost(comment: Comment)
  func presentError(_ error: MartianError)
}

class CommentingPresenter {
  weak var viewController: CommentingDisplayLogic?
}

// MARK: - Presentation Logic
extension CommentingPresenter: CommentingPresentationLogic {
  func presentSuccessfulCommentPost(comment: Comment) {
    viewController?.displaySuccessfulCommentPost(comment: comment)
  }
  
  func presentError(_ error: MartianError) {
    viewController?.displayError(title: error.localisedTitle, message: error.localizedDescription)
  }
}
