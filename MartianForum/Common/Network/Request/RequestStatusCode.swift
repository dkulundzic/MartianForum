//
//  RequestStatusCode.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum RequestStatusCode {
  static var valid: ClosedRange<Int> {
    return 200...299
  }
}
