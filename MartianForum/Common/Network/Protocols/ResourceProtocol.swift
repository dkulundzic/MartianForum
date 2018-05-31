//
//  RouteProtocol.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol ResourceProtocol {
  func endpoint(for method: HttpRequest.Method) -> String
}
