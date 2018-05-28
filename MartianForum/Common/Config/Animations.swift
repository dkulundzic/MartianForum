//
//  Animations.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

public struct Animations {
	public struct Default {
		public static let defaultAnimationDuration: TimeInterval = 0.35
	}
	
	public struct Spring {
		public static let defaultSpringAnimationDuration: TimeInterval = 0.5
		public static let defaultSpringDamping: CGFloat = 0.75
		public static let defaultSpringInitialVelocity: CGFloat = 0.0
	}
}
