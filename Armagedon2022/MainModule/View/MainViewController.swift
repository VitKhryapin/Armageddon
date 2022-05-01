//
//  MainViewController.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let idCell = "Cell"
    var presenter: MainPresenterProtocol!
    var distanceString = ""
    var countDay = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AsteroidTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Армагедон2022"
        let navItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .done, target: self, action: #selector(tapFilter))
        self.navigationItem.rightBarButtonItem = navItem
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.backButtonTitle = "Назад"
        presenter.filtredAsteroids()
        tableView.reloadData()
    }
    
    @objc func tapFilter() {
        presenter.showFilter()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.filterAsteroidsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! AsteroidTableViewCell
        if (presenter.filterAsteroidsList.count - indexPath.section ) < 3 {
            presenter.getAsteroids(day: countDay)
        }
        cell.buttonAction = { sender in
            let asteroid = self.presenter.filterAsteroidsList[indexPath.section]
            self.presenter.addInTrashAsteroidList(asteroid: asteroid)
        }
        return cell.settings(presenters: presenter, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 308
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asteroid = presenter.filterAsteroidsList[indexPath.section]
        let alert = Alert().alertDetail(asteroid: asteroid, indexPath: indexPath) { asteroid in
            self.presenter.addInTrashAsteroidList(asteroid: asteroid)
        }
        self.present(alert, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        self.presenter.timer?.invalidate()
        countDay += 1
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func failer(error: Error) {
        self.presenter.createTimer(day: countDay)
        let alert = Alert().erorrNetwork()
        self.present(alert, animated: true) {
            self.presenter.getAsteroids(day: 0)
        }
        print(error.localizedDescription)
    }
}


