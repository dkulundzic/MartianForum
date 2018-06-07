//
//  PostsMock.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation
@testable import MartianForum

struct PostsMock {
  static func posts() throws -> [Post] {
    return try Mocker.objects(from: "posts")
  }
}
