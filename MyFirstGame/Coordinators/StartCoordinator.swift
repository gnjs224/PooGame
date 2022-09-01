//
//  StartCoordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//

import UIKit

class StartCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StartViewController()
        vc.coordinator = self
        self.navigationController.viewControllers = [vc]
    }
    func showGameViewController() {
        let coordinator = GameCoordinator(navigationController: self.navigationController)
        coordinator.parentCoordinator = self
        childCoordinators = [coordinator]
        coordinator.start()
    }
    func appExit() {
        print("exit")
//        exit()
    }
    func showSettingViewController() {
        
        let coordinator = SettingCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
        
    }

}
