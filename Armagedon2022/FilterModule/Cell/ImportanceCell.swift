//
//  ImportanceCell.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import UIKit

class ImportanceCell: UITableViewCell {
    @IBOutlet weak var switchOutlet: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchOutlet.isOn = Filter.shared.currentSettings.importance
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
    }
    
}
