//
//  KeychainService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

public func == (lhs: StartupProcess, rhs: StartupProcess) -> Bool {
	return lhs.id == rhs.id
}

/**
An abstraction for a predefined set of functionality, aimed to be ran once, at app startup.
*/
public protocol StartupProcess {
	var id: String { get }
	func run(completion: @escaping (Bool) -> Void)
}
