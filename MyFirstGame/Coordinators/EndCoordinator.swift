//
//  EndCoordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//

import UIKit

class EndCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = EndViewController()
        if let parentCoordinator = parentCoordinator as? GameCoordinator {
            vc.score = parentCoordinator.score
        }
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
//        print(navigationController.viewControllers)
    }
    func showNewGameViewController() {
//        print("replay game", navigationController.viewControllers)
        navigationController.popViewController(animated: false)
        if let parentCoordinator = parentCoordinator as? GameCoordinator {
            parentCoordinator.showNewGameViewController()
        }
       
        
    }
    func popToStartViewController() {
        navigationController.popViewController(animated: false)
        if let parentCoordinator = parentCoordinator as? GameCoordinator {
            parentCoordinator.popToStartViewController()
        }
    }
    
}
