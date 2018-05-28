//
//  URL-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		guard let url = URL(string: value) else {
			fatalError("Invalid URL string.")
		}
		self = url
	}
}
