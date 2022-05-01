//
//  FilterPresenter.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation

protocol FilterViewPresentorProtocol {
    init(router: RouterProtocol)
    func tapSave(unitCell: UnitsCell, importanceCell: ImportanceCell)
}


class FilterPresentor: FilterViewPresentorProtocol {
    
    var router: RouterProtocol?
   
    required init(router: RouterProtocol) {
        self.router = router
    }
    
    func tapSave(unitCell: UnitsCell, importanceCell: ImportanceCell) {
        Filter.shared.currentSettings.unit = unitCell.segmentControl.selectedSegmentIndex
        Filter.shared.currentSettings.importance = importanceCell.switchOutlet.isOn
        router?.popToRoot()
    }
}
