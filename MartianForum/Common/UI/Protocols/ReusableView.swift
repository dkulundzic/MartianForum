//
//  ReusableView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension UIView: ReusableView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
