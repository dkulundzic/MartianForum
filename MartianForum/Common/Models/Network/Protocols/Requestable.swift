//
//  Requestable.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol Requestable: Codable {
  static var resource: ResourceProtocol { get }  
}
