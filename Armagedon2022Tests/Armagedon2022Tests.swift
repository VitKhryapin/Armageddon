//
//  Armagedon2022Tests.swift
//  Armagedon2022Tests
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import XCTest
@testable import Armagedon2022

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failer(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var asteroids: ClosestAsteroidsRoot!
    init() {}
    convenience init(asteroids: ClosestAsteroidsRoot?) {
        self.init()
        self.asteroids = asteroids
    }
    
    func getObjects(completion: @escaping (Result<ClosestAsteroidsRoot?, Error>) -> ()) {
        if let asteroids = asteroids {
            completion(.success(asteroids))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    var countDay: Int = 0
}

class Armagedon2022Tests: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var asteroids = [ClosestAsteroidsRoot]()
    var objArray = [NearEarthObject]()
    
    override func setUpWithError() throws {
        let tabBar = UITabBarController()
        let mainNavigationController = UINavigationController()
        let trashNavigationController = UINavigationController()
        let assemblyBuilder = AssemblyModuleBuilder()
        router = Router(tabBarController: tabBar, mainNavigationController: mainNavigationController, trashNavigationController: trashNavigationController, assemblyBuilder: assemblyBuilder, trashAsteroidsList: objArray)
    }
    
    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccessAsteroids() {
        let asteroid = ClosestAsteroidsRoot(
            links: ClosestAsteroidsLinks(next: "linkNext", prev: "linkPrev", linksSelf: "linkSelf"),
            elementCount: 1,
            nearEarthObjects: ["1" : [NearEarthObject(links: NearEarthObjectLinks(linksSelf: "nearLinkSelf"),
                                                      id: "id",
                                                      neoReferenceID: "neoId",
                                                      name: "name",
                                                      nasaJplURL: "nasaJpl",
                                                      absoluteMagnitudeH: 1,
                                                      estimatedDiameter: EstimatedDiameter(kilometers: Feet(estimatedDiameterMin: 1,
                                                                                                            estimatedDiameterMax: 1),
                                                                                           meters: Feet(estimatedDiameterMin: 1,
                                                                                                        estimatedDiameterMax: 1),
                                                                                           miles: Feet(estimatedDiameterMin: 1,
                                                                                                       estimatedDiameterMax: 1),
                                                                                           feet: Feet(estimatedDiameterMin: 1,
                                                                                                      estimatedDiameterMax: 1)),
                                                      isPotentiallyHazardousAsteroid: true,
                                                      closeApproachData: [CloseApproachDatum(closeApproachDate: "closeDate",
                                                                                             closeApproachDateFull: nil,
                                                                                             epochDateCloseApproach: 1,
                                                                                             relativeVelocity: RelativeVelocity(kilometersPerSecond: "1",
                                                                                                                                kilometersPerHour: "1",
                                                                                                                                milesPerHour: "1"),
                                                                                             missDistance: MissDistance(astronomical: "1",
                                                                                                                        lunar: "1",
                                                                                                                        kilometers: "1",
                                                                                                                        miles: "1"),
                                                                                             orbitingBody: OrbitingBody.earth)],
                                                      isSentryObject: false)]])
        asteroids.append(asteroid)
        view = MockView()
        networkService = MockNetworkService(asteroids: asteroids[0])
        presenter = MainPresenter(mainView: view, networkService: networkService, router: router)
        var carchAsteroids: ClosestAsteroidsRoot?
        
        networkService.getObjects(completion: { result in
            switch result {
            case .success(let asteroids):
                carchAsteroids = asteroids
            case .failure(let error):
                print(error.localizedDescription)
            }
            XCTAssertNotNil(carchAsteroids)
        })
        
        func testGetFailureAsteroids() {
            let asteroid = ClosestAsteroidsRoot(
                links: ClosestAsteroidsLinks(next: "linkNext", prev: "linkPrev", linksSelf: "linkSelf"),
                elementCount: 1,
                nearEarthObjects: ["1" : [NearEarthObject(links: NearEarthObjectLinks(linksSelf: "nearLinkSelf"),
                                                          id: "id",
                                                          neoReferenceID: "neoId",
                                                          name: "name",
                                                          nasaJplURL: "nasaJpl",
                                                          absoluteMagnitudeH: 1,
                                                          estimatedDiameter: EstimatedDiameter(kilometers: Feet(estimatedDiameterMin: 1,
                                                                                                                estimatedDiameterMax: 1),
                                                                                               meters: Feet(estimatedDiameterMin: 1,
                                                                                                            estimatedDiameterMax: 1),
                                                                                               miles: Feet(estimatedDiameterMin: 1,
                                                                                                           estimatedDiameterMax: 1),
                                                                                               feet: Feet(estimatedDiameterMin: 1,
                                                                                                          estimatedDiameterMax: 1)),
                                                          isPotentiallyHazardousAsteroid: true,
                                                          closeApproachData: [CloseApproachDatum(closeApproachDate: "closeDate",
                                                                                                 closeApproachDateFull: nil,
                                                                                                 epochDateCloseApproach: 1,
                                                                                                 relativeVelocity: RelativeVelocity(kilometersPerSecond: "1",
                                                                                                                                    kilometersPerHour: "1",
                                                                                                                                    milesPerHour: "1"),
                                                                                                 missDistance: MissDistance(astronomical: "1",
                                                                                                                            lunar: "1",
                                                                                                                            kilometers: "1",
                                                                                                                            miles: "1"),
                                                                                                 orbitingBody: OrbitingBody.earth)],
                                                          isSentryObject: false)]])
            asteroids.append(asteroid)
            view = MockView()
            networkService = MockNetworkService(asteroids: asteroids[0])
            presenter = MainPresenter(mainView: view, networkService: networkService, router: router)
            var catchError: Error?
            
            networkService.getObjects(completion: { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    catchError = error
                }
            })
            XCTAssertNotNil(catchError)
        }
        
        
        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
        
    }
}
