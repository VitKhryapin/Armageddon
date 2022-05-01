//
//  Router.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

protocol RouterMain {
    var mainNavigationController: UINavigationController? {get set}
    var trashNavigationController: UINavigationController? {get set}
    var tabBarController: UITabBarController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
    var trashAsteroidsList: [NearEarthObject] {get set}
    
}

protocol RouterProtocol:RouterMain {
    func initialViewController()
    func showFilter()
    func popToRoot()
    func addInTrashAsteroidsList(asteroids: NearEarthObject)
    func trashSelectedAsteroids()
    func delisting(index: Int)
}

class Router: RouterProtocol {
    var tabBarController: UITabBarController?
    var mainNavigationController: UINavigationController?
    var trashNavigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var trashAsteroidsList: [NearEarthObject]
    
    
    init(tabBarController: UITabBarController, mainNavigationController: UINavigationController, trashNavigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol, trashAsteroidsList: [NearEarthObject]) {
        self.tabBarController = tabBarController
        self.mainNavigationController = mainNavigationController
        self.trashNavigationController = trashNavigationController
        self.assemblyBuilder = assemblyBuilder
        self.trashAsteroidsList = trashAsteroidsList
    }
    
    func initialViewController() {
        if let tabBarController = tabBarController {
            if let mainNavigationController = mainNavigationController {
                guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
                mainNavigationController.viewControllers = [mainViewController]
            }
            if let trashNavigationController = trashNavigationController {
                guard let trashViewController = assemblyBuilder?.createTrashModule(router: self) else { return }
                trashNavigationController.viewControllers = [trashViewController]
            }
            guard let mainNavigationController = mainNavigationController else { return }
            guard let trashNavigationController = trashNavigationController else { return }
            tabBarController.setViewControllers([mainNavigationController, trashNavigationController], animated: true)
        }
        
    }
    
    func showFilter() {
        if let navigationController = mainNavigationController {
            guard let filterViewController = assemblyBuilder?.createFilterModule(router: self) else { return }
            navigationController.pushViewController(filterViewController, animated: true)
        }
        tabBarController?.tabBar.isHidden = true
    }
    
    func popToRoot() {
        if let navigationController = mainNavigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func addInTrashAsteroidsList(asteroids: NearEarthObject) {
        var checkAsteroid = 0
        for asteroid in trashAsteroidsList {
            if asteroid.id == asteroids.id {
                checkAsteroid += 1
                break
            }
        }
        if checkAsteroid == 0 {
            trashAsteroidsList.append(asteroids)
        }
    }
    
    func trashSelectedAsteroids() {
        trashAsteroidsList.removeAll()
    }
    
    func delisting(index: Int) {
        trashAsteroidsList.remove(at: index)
    }
}

