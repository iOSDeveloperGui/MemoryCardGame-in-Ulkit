//
//  AppCoordinator.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import Foundation
import UIKit

protocol Coordinator{
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator{
    //MARK: - Property
    var navigationController: UINavigationController
    
    //MARK: - Initializer
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    //MARK: - StartMethod
    public func start(){
        let gameView = GameView()
        let viewModel = CardViewModel()
        let gameViewController = GameViewController(contentView: gameView, viewModel: viewModel)
        navigationController.pushViewController(gameViewController, animated: true)
    }
}
