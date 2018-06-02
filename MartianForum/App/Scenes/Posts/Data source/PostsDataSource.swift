//
//  PostsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PostsDataSource: DataSourceProtocol {
  private(set) var sections = [PostsSection]()
  private(set) var posts = [PostUser]()
  
  init() {
    buildSections()
  }
}

extension PostsDataSource {
  func addPosts(_ posts: [PostUser]) {
    self.posts = posts
    sections.removeAll()
    buildSections()
  }
}

private extension PostsDataSource {
  func buildSections() {
    let rows = posts.map { PostsRow.post(
      PostCell.ViewModel(author: $0.user.username, title: $0.post.title), $0)
    }
    sections.append(PostsSection.posts(rows))
  }
}
