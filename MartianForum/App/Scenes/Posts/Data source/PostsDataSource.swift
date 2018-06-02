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
  private(set) var posts = [Post]()
  
  init() {
    buildSections()
  }
}

extension PostsDataSource {
  func addPosts(_ posts: [Post]) {
    self.posts = posts
    sections.removeAll()
    buildSections()
  }
}

private extension PostsDataSource {
  func buildSections() {
    let rows = posts.map { PostsRow.post(
      PostCell.ViewModel(title: $0.title, body: $0.body), $0)
    }
    sections.append(PostsSection.posts(rows))
  }
}
