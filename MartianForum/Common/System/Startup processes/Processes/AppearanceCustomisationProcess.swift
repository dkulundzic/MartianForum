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
		
		UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().tintColor = .martianGray
		UINavigationBar.appearance().prefersLargeTitles = true
		UINavigationBar.appearance().titleTextAttributes = [
			NSAttributedStringKey.foregroundColor: UIColor.martianGray
		]
		UINavigationBar.appearance().largeTitleTextAttributes = UINavigationBar.appearance().titleTextAttributes
    
    UITabBar.appearance().tintColor = .martianRed
    UITabBar.appearance().barTintColor = .white
		
		completion(true)
	}
}
