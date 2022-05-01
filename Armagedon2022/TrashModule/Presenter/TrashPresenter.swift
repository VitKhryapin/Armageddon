//
//  TrashPresenter.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation

protocol TrashViewProtocol: AnyObject {
    func success()
    func failer(error: Error)
}

protocol TrashPresenterProtocol: AnyObject {
    init(trashView: TrashViewProtocol, router: RouterProtocol)
    var trashList: [NearEarthObject]! {get}
    func getTrashList()
    func trashSelectedAsteroids()
    func delisting(index: Int)
}

class TrashPresenter: TrashPresenterProtocol {
    weak var trashView: TrashViewProtocol?
    var router: RouterProtocol?
    var trashList: [NearEarthObject]!
   
    
    required init(trashView: TrashViewProtocol, router: RouterProtocol) {
        self.router = router
        self.trashView = trashView
    }
    
    func getTrashList() {
        trashList = router?.trashAsteroidsList
    }
    
    func trashSelectedAsteroids() {
        router?.trashSelectedAsteroids()
        self.getTrashList()
    }
    
    func delisting(index: Int) {
        router?.delisting(index: index)
        self.getTrashList()
    }

}
