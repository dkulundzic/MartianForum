//
//  UIBarButtonItem-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//
import UIKit

extension UIBarButtonItem {
  static func loadingIndicator(_ style: UIActivityIndicatorViewStyle = .gray, tintColor: UIColor? = nil) -> UIBarButtonItem {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
    activityIndicator.color = tintColor
    activityIndicator.startAnimating()
    return UIBarButtonItem(customView: activityIndicator)
  }
}
