//
//  PostDetailsRow.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum PostDetailsRow {
  case title(PostDetailsTitleCell.ViewModel)
  case comment(PostDetailsCommentCell.ViewModel)
}
