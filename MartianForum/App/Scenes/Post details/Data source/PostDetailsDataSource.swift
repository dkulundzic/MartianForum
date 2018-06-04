//
//  PostDetailsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PostDetailsDataSource: DataSourceProtocol {
  let post: PostUser
  private var comments = [Comment]()
  private(set) var sections = [PostDetailsSection]()
  
  init(post: PostUser) {
    self.post = post
    buildSections()
  }
}

extension PostDetailsDataSource {
  func addComment(_ comment: Comment) {
    comments.append(comment)
    buildSections()
  }
  
  func addComments(_ comments: [Comment]) {
    self.comments = comments
    buildSections()
  }
  
  func copyText(at indexPath: IndexPath) -> String? {
    guard let row = section(at: indexPath.section)?.row(at: indexPath.row) else {
      Logger.debug("Couldn't extract the row for the specified comment at \(indexPath.debugDescription).")
      return nil
    }
    
    switch row {
    case .title(_, let title, let body):
      return "\(title)\n\(body)"
    case .comment(_, let body):
      return body
    case .input:
      return nil
    }
  }
}

private extension PostDetailsDataSource {
  func buildSections() {
    sections.removeAll()
    
    var rows = [PostDetailsRow]()
    rows.append(
      PostDetailsRow.title(PostDetailsTitleCell.ViewModel(post.user.username, post.post.title, post.post.body))
    )
    rows.append(contentsOf:
      comments.map {
        PostDetailsRow.comment(PostDetailsCommentCell.ViewModel("\($0.email)", $0.body))
      }
    )
    rows.append(.input)
    
    sections.append(PostDetailsSection.postDetails(rows))
  }
}
