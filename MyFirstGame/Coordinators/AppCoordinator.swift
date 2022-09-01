//
//  AppCoordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//
import UIKit
class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        self.showStartViewController()
    }
    private func showStartViewController() {
        let coordinator = StartCoordinator(navigationController: self.navigationController)
        coordinator.parentCoordinator = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
  
}
