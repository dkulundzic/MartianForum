//
//  CommentingInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol CommentingBusinessLogic {
  
}

class CommentingInteractor {
  var presenter: CommentingPresentationLogic?
}

// MARK: - Business Logic
extension CommentingInteractor: CommentingBusinessLogic {
  
}
