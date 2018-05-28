//
//  Logger.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class Logger {
	typealias Json = [String: Any]
	static let shared = Logger()
	var logLevel: LogLevel = Environment.isProduction ? .info : .debug
}

// MARK: - Public Methods
extension Logger {
	static func debug(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
		if shared.logLevel.rawValue >= LogLevel.debug.rawValue {
			flush(.debug, message: message, params: params, file: file, function: function, line: line)
		}
	}
	
	static func info(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
		if shared.logLevel.rawValue >= LogLevel.info.rawValue {
			flush(.info, message: message, params: params, file: file, function: function, line: line)
		}
	}
	
	static func warning(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
		if shared.logLevel.rawValue >= LogLevel.warn.rawValue {
			flush(.warn, message: message, params: params, file: file, function: function, line: line)
		}
	}
	
	static func error(_ message: String, params: Json?=nil, file: String = #file, function: String = #function, line: Int = #line) {
		if shared.logLevel.rawValue >= LogLevel.error.rawValue {
			flush(.error, message: message, params: params, file: file, function: function, line: line)
		}
	}
}

// MARK: - Private Methods
private extension Logger {
	static func flush(_ level: LogLevel, message: String, params: Json?=nil, file: String, function: String, line: Int) {
		let fileName = URL(fileURLWithPath: file).lastPathComponent.components(separatedBy: ".").first ?? ""
		let validParams = params == nil ? "" : ", params: \(params ?? Json())"
		
		// log remote only if not debug and app environment is not testing
		if shared.logLevel.rawValue >= level.rawValue {
			debugPrint("\(level.string()): \(fileName).\(function)[\(line)]: \(message)\(validParams)")
			debugPrint()
		}
	}
}
