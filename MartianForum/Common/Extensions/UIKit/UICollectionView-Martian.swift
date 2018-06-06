//
//  UICollectionView-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit
import Promises

public extension UICollectionView {    
	func register<T: UICollectionViewCell>(_: T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, kind: String) {
		register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func dequeuReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
	
	func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, at indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			Logger.error("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier). Creating new instance.")
			return T()
		}
		return cell
	}
	
	func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, forIndexPath indexPath: IndexPath) -> T {
		guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue supplementary view (\(kind)) with identifier: \(T.defaultReuseIdentifier)")
		}
		return view
	}
}

public extension UICollectionView {
  func performBatchUpdates(update: @escaping () -> Void) -> Promise<Void> {
    return Promise<Void> { fulfill, reject in
      self.performBatchUpdates(update, completion: { completed in
        completed ? fulfill(()): reject(NetworkError.generic)
      })
    }
  }
}
