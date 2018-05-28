//
//  ClosureDefinition.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

typealias ArgumentlessCompletion = (() -> Void)?
typealias Completion<T> = ((T) -> Void)?
typealias Failure = ((MartianError) -> Void)?
