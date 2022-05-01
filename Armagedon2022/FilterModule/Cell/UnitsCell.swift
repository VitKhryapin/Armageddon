//
//  SettingsCell.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class UnitsCell: UITableViewCell {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentControl.selectedSegmentIndex = Filter.shared.currentSettings.unit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
    }
    
}
