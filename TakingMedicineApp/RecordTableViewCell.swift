//
//  RecordTableViewCell.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/29.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var medicineNameLabel: UILabel!
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
