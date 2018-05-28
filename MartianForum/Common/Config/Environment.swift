//
//  Environment.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

public enum Environment {
	#if CONFIGURATION_Debug
	public static let isDebug = true
	#else
	public static let isDebug = false
	#endif
	
	// WARNING: A lot of features (logging) on this variable
	// isProduction *MUST* only be true for App Store builds.
	//
	// TODO: Needs to configure this one
	#if CONFIGURATION_AppStore
	public static let isProduction = true
	#else
	public static let isProduction = false
	#endif
	
	public static let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
