//
//  UIAlertController-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func generic(title: String?,
                      message: String? = "",
                      preferredStyle: UIAlertControllerStyle = .alert,
                      actions: [UIAlertAction] = [],
                      cancelTitle: String = "default_alert_cancel_title".localized()) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    
    actions.forEach { action in
      alertController.addAction(action)
    }
    
    if !actions.contains { $0.style == .cancel } {
      alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
    }
    
    return alertController
  }
  
  func present(on viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
    viewController.present(self, animated: animated, completion: completion)
  }
}
