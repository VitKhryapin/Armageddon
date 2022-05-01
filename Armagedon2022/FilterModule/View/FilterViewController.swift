//
//  FilterViewController.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    let unitsCell = "unitsCell"
    let importanceCell = "importanceCell"
    var presentor: FilterViewPresentorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView()
    }
    
    func settingsView() {
        navigationItem.title = "Фильтр"
        let navItem = UIBarButtonItem(title: "Применить", style: .plain, target: self, action: #selector(tapSave))
        self.navigationItem.rightBarButtonItem = navItem
        tableView.register(UINib(nibName: "UnitsCell", bundle: nil), forCellReuseIdentifier: unitsCell)
        tableView.register(UINib(nibName: "ImportanceCell", bundle: nil), forCellReuseIdentifier: importanceCell)
    }
    
    @objc func tapSave() {
        let indexPathUnits = IndexPath(row: 0, section: 0)
        let indexPathImportance = IndexPath(row: 1, section: 0)
        let cellUnits = tableView.cellForRow(at: indexPathUnits) as! UnitsCell
        let cellImportance = tableView.cellForRow(at: indexPathImportance) as! ImportanceCell
        presentor.tapSave(unitCell: cellUnits, importanceCell: cellImportance)
    }
}
 
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let units = tableView.dequeueReusableCell(withIdentifier: unitsCell, for: indexPath) as! UnitsCell
        let importance = tableView.dequeueReusableCell(withIdentifier: importanceCell, for: indexPath) as! ImportanceCell
        if indexPath.item == 0 {
            return units
        } else {
            return importance
        }
    }
}


