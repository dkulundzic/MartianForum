//
//  PostsRow.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum PostsRow {
  case title(PostsTitleCell.ViewModel)
  case comment(PostsCommentCell.ViewModel)
}
