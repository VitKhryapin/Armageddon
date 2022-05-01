//
//  MainPresenter.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failer(error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    init(mainView: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getAsteroids(day: Int)
    func showFilter()
    var asteroids: ClosestAsteroidsRoot? {get}
    var asteroidsList: [NearEarthObject] {get}
    var filterAsteroidsList: [NearEarthObject] {get}
    func filtredAsteroids()
    var timer: Timer? {get}
    func createTimer(day: Int)
    func addInTrashAsteroidList(asteroid: NearEarthObject)
}

class MainPresenter: MainPresenterProtocol {
    
    weak var mainView: MainViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol!
    var asteroids: ClosestAsteroidsRoot?
    var asteroidsList: [NearEarthObject] = []
    var filterAsteroidsList: [NearEarthObject] = []
    var timer: Timer?
    
    
    required init(mainView: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.mainView = mainView
        self.networkService = networkService
        self.router = router
        getAsteroids(day: 0)
    }
    
    @objc func getAsteroids(day: Int) {
        networkService.countDay = day
        networkService.getObjects { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let asteroids):
                    guard let asteroids = asteroids else { return }
                    self.asteroids = asteroids
                    self.fetchData(from: asteroids)
                    self.filtredAsteroids()
                    self.mainView?.success()
                case .failure(let error):
                    self.mainView?.failer(error: error)
                }
            }
        }
    }
    
    func showFilter() {
        router?.showFilter()
    }
    
    func fetchData(from closestAsteroids: ClosestAsteroidsRoot) {
        for cA in closestAsteroids.nearEarthObjects {
            for a in cA.value {
                self.asteroidsList.append(a)
            }
        }
    }
    
    func filtredAsteroids() {
        if Filter.shared.currentSettings.importance {
            filterAsteroidsList = asteroidsList.filter {$0.isPotentiallyHazardousAsteroid}
        } else {
            filterAsteroidsList = asteroidsList
        }
    }
    
    func createTimer(day: Int) {
        let dateFormatter = DateFormatter()
        networkService.countDay = 0
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0,
                                         target: self,
                                         selector: #selector(getAsteroids(day:)),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    func addInTrashAsteroidList(asteroid: NearEarthObject) {
        router?.addInTrashAsteroidsList(asteroids: asteroid)
    }
}



