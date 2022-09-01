//
//  SettingCoordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//

import UIKit

class SettingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = SettingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: false)
    }
    

}
