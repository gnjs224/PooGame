//
//  Coordinator.swift
//  MyFirstGame
//
//  Created by 김지훈 on 2022/09/01.
//
import UIKit
protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
