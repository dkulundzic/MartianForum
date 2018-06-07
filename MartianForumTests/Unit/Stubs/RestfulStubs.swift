//
//  RestfulStubs.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation
@testable import MartianForum

struct RestfulStubs<M: Requestable> {
  let resource: ResourceProtocol = M.resource
  
  func stubGetRequest(responseStatusCode: Int = 200) {
    let url = URLs.apiURL.appendingPathComponent(resource.endpoint).absoluteString
    Logger.debug("Stubbing GET \(url)")
    Mocker.stub(url: url, method: .get, responseStatusCode: responseStatusCode, responseBody: Mocker.loadFile(named: resource.endpoint))
  }
  
  func stubGetByIdRequest(id: Int, responseStatusCode: Int = 200) {
    let url = URLs.apiURL.appendingPathComponent("\(resource.endpoint)/\(id.description)").absoluteString
    Logger.debug("Stubbing GET \(url)")
    Mocker.stub(url: url, method: .get, responseStatusCode: responseStatusCode, responseBody: Mocker.loadFile(named: resource.endpoint))
  }
  
  func stubPostRequest(responseStatusCode: Int = 200) {
    let url = URLs.apiURL.appendingPathComponent(resource.endpoint).absoluteString
    Logger.debug("Stubbing POST \(url)")
    Mocker.stub(url: url, method: .post, responseStatusCode: responseStatusCode)
  }
  
  func stubUpdateRequest(id: Int, responseStatusCode: Int = 200) {
    let url = URLs.apiURL.appendingPathComponent("\(resource.endpoint)/\(id.description)").absoluteString
    Logger.debug("Stubbing PUT \(url)")
    Mocker.stub(url: url, method: .put, responseStatusCode: responseStatusCode)
  }
  
  func stubDeleteRequest(id: Int, responseStatusCode: Int = 200) {
    let url = URLs.apiURL.appendingPathComponent("\(resource.endpoint)/\(id.description)").absoluteString
    Logger.debug("Stubbing DELETE \(url)")
    Mocker.stub(url: url, method: .delete, responseStatusCode: responseStatusCode)
  }
}
