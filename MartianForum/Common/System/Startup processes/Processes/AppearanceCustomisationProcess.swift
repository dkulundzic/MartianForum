//
//  AppearanceCustomisationProcess.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

public final class AppearanceCustomisationProcess: StartupProcess {
	public var id: String = UUID().uuidString
	
	public func run(completion: @escaping (Bool) -> Void) {
		UIApplication.shared.statusBarStyle = .lightContent
		UIScrollView.appearance().showsVerticalScrollIndicator = false
		UIScrollView.appearance().showsHorizontalScrollIndicator = false
		
		UINavigationBar.appearance().barTintColor = UIColor.white
		UINavigationBar.appearance().tintColor = UIColor.white
		UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().prefersLargeTitles = true
		UINavigationBar.appearance().titleTextAttributes = [
			NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30),
			NSAttributedStringKey.foregroundColor: UIColor.white
		]
		UINavigationBar.appearance().largeTitleTextAttributes = UINavigationBar.appearance().titleTextAttributes
		
		completion(true)
	}
}
