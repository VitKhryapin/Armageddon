//
//  AssemblyModuleBilder.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createTrashModule(router: RouterProtocol) -> UIViewController
    func createFilterModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(mainView: view, networkService: networkService, router: router)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(title: "Астероиды", image: UIImage(systemName: "globe"), tag: 0)
        return view
    }
    
    func createTrashModule(router: RouterProtocol) -> UIViewController {
        let view = TrashViewController()
        let presenter = TrashPresenter(trashView: view, router: router)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(title: "Уничтожение", image: UIImage(systemName: "trash"), tag: 1)
        return view
    }
    
    func createFilterModule(router: RouterProtocol) -> UIViewController {
        let view = FilterViewController()
        let presenter = FilterPresentor(router: router)
        view.presentor = presenter
        return view
    }
}
