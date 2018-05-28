//
//  String-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

public extension String {
	func localized(_ args: CVarArg...) -> String {
		guard !self.isEmpty else { return self }
		let localizedString = NSLocalizedString(self, comment: "")
		return withVaList(args) { NSString(format: localizedString, locale: Locale.current, arguments: $0) as String }
	}
}
