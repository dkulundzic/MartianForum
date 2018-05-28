//
//  LogLevel.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum LogLevel: Int {
    case none = 0
    case error = 1
    case warn = 2
    case info = 3
    case debug = 4
    case all = 10
    
    func string() -> String {
        switch self {
        case .info:
            return "INFO"
        case .warn:
            return "WARN"
        case .debug:
            return "DEBUG"
        case .error:
            return "ERROR"
        default:
            return ""
        }
    }
}
