//
//  PostDetailsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PostDetailsDataSource: DataSourceProtocol {
  private let post: PostUser
  private var comments = [Comment]()
  private(set) var sections = [PostDetailsSection]()
  
  init(post: PostUser) {
    self.post = post
    buildSections()
  }
}

extension PostDetailsDataSource {
  func addComments(_ comments: [Comment]) {
    self.comments = comments
    buildSections()
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
        PostDetailsRow.comment(PostDetailsCommentCell.ViewModel("\($0.name)\n(\($0.email))", $0.body))
      }
    )
    
    sections.append(PostDetailsSection.postDetails(rows))
  }
}
