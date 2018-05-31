//
//  DataSourceProtocol.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol DataSourceProtocol {
	associatedtype Section: SectionProtocol
	var sections: [Section] { get }
	var isEmpty: Bool { get }
}

extension DataSourceProtocol {
	var isEmpty: Bool {
		guard numberOfSections() > 0 else {
			return true
		}
		
		for section in 0..<numberOfSections() {
			if numberOfRows(in: section) > 0 {
				return false
			}
		}
		
		return true
	}
	
	func numberOfSections() -> Int {
		return sections.count
	}
	
	func numberOfRows(in section: Int) -> Int {
		guard let section = sections[safe: section] else { return 0 }
		return section.isCollapsed ? 0 : section.rows.count
	}
	
	func section(at index: Int) -> Section? {
		return sections[safe: index]
	}
}

protocol SectionProtocol {
	associatedtype Row
	var rows: [Row] { get }
	var isCollapsed: Bool { get }
}

extension SectionProtocol {
	var isCollapsed: Bool {
		return false
	}

	func row(at index: Int) -> Row? {
		return rows[safe: index]
	}
}
