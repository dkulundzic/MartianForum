//
//  StartupProcessService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

public final class StartupProcessService {
	
	public init() { }
	
	@discardableResult
	public func execute(process: StartupProcess) -> StartupProcessService {
		process.run { (success) in
			if success {
				Logger.debug("Successfully ran the \(type(of: process)) process.")
			}
		}
		
		return self
	}
	
}
