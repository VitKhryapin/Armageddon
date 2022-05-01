//
//  TrashViewController.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class TrashViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var trashButton: UIButton!
    
    var presenter: TrashPresenterProtocol!
    
    let idCell = "TrashCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Уничтожение"
        trashButton.layer.cornerRadius = 10
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TrashTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getTrashList()
        tableView.reloadData()
    }
    
    
    
    
    @IBAction func trashButtonAction(_ sender: UIButton) {
        let alert = Alert().goToTheBruceCommand()
        self.present(alert, animated: true) 
        presenter.trashSelectedAsteroids()
        tableView.reloadData()
    }
}

extension TrashViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.trashList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! TrashTableViewCell
        cell.nameLabel.text = "\(presenter.trashList[indexPath.row].name.getFormatName())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asteroid = presenter.trashList[indexPath.row]
        let alert = Alert().secondAlertDetail(asteroid: asteroid, indexPath: indexPath)
        self.present(alert, animated: true) {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Убрать из списка") { (action, sourceView, completionHandler) in
            self.presenter.delisting(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.systemOrange
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfig
    }
}

extension TrashViewController: TrashViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failer(error: Error) {
        print(error.localizedDescription)
    }
}

