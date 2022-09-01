//
//  GameCoordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//

import UIKit

class GameCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var score = 0
    var navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start() {
        let vc = GameViewController()
        vc.coordinator = self

//        print("\(self)")
        self.navigationController.pushViewController(vc, animated: false)
    }
    func showEndViewController() {
        let coordinator = EndCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    func showNewGameViewController() {
        navigationController.popViewController(animated: false)
        if let parentCoordinator = parentCoordinator as? StartCoordinator {
            parentCoordinator.showGameViewController()
        }
    }
    func popToStartViewController() {
        if let parentCoordinator = parentCoordinator as? StartCoordinator {
            parentCoordinator.start()
        }
    }
}
