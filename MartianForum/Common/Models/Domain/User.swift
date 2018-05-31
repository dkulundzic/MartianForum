//
//  User.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct User: Requestable {
  static var resource: ResourceProtocol {
    return Resource.users(nil)
  }
  
  let id: Int
  let name: String
  let username: String
  let email: String
  let phone: String
  let website: String
  let address: Address
  let company: Company
}

extension User {
  struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Address.Geo
  }
  
  struct Company: Codable {
    let name: String
    let catchPrase: String
    let bs: String
  }
}

extension User.Address {  
  struct Geo: Codable {
    let lat: Double
    let lng: Double
  }
}
