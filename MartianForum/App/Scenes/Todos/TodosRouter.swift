//
//  TodosRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol TodosRoutingLogic {
  
}

protocol TodosRouterDelegate: class {
  
}

class TodosRouter {
  weak var viewController: TodosViewController?
  weak var delegate: TodosRouterDelegate?
}

// MARK: - Routing Logic
extension TodosRouter: TodosRoutingLogic {
  
}
