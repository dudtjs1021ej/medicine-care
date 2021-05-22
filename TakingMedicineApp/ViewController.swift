//
//  ViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/20.
//

import UIKit

var medicineNames = ["test"]
var date = DateComponents(hour:3, minute: 12)
var alarmTimes = [date]
//var medicineNames:[String]? //알림받을 목록 중 약 이름

class ViewController: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension ViewController{
    override func viewWillAppear(_ animated: Bool) {
        alarmTableView.reloadData() //viewWillAppear가 호출 될 때마다 테이블뷰 다시 로드
    }
}

extension ViewController:UITableViewDelegate{
    
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return medicineNames.count
        if medicineNames != nil{
            return medicineNames.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell",for: indexPath) as! TableViewCell
        cell.medicineNameLabel.text = medicineNames[(indexPath as NSIndexPath).row] //textLabel은 약 이름
       
        let alarmTime = alarmTimes[(indexPath as NSIndexPath).row]
        let alarmTimeString = "\(String(alarmTime.hour!)):\(String(alarmTime.minute!))"
        cell.alarmTimeLabel.text = alarmTimeString
        
        return cell
        
    }
    
    
}
