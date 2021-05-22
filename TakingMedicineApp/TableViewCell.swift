//
//  TableViewCell.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var medicineNameLabel: UILabel!
    
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func alarmButton(_ sender: UIButton) {
    }
}
