//
//  RecordViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/29.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 50 //tableView 높이를 100으로
        tableView.layer.cornerRadius = 12.0 //tableView를 둥글게
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

extension RecordViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineNames.count-1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = ((indexPath as NSIndexPath).row)+1
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell",for: indexPath) as! RecordTableViewCell
        cell.medicineNameLabel.text = medicineNames[index] //textLabel은 약 이름
        if medicineTake[index] == true{ //약을 복용을 했다면
            cell.checkImageView.image = UIImage(systemName: "checkmark.seal.fill")
           
        }else{ //복용하지 않았다면
            cell.checkImageView.image = UIImage(systemName: "checkmark.seal")
        }
        return cell
        }
    
}
