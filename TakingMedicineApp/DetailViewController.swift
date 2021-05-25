//
//  DetailViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var medicineNameTextField: UITextField!
    
    
    @IBOutlet weak var myView: UIView!
    
    var receiveIndex : Int?
    
    var datePickerHour: Int! //수정할 시간
    var datePickerMinute: Int! //수정할 분

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.layer.cornerRadius = 12
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture) //키보드 사라지게 함
        
        medicineNameTextField.text = medicineNames[receiveIndex!] //선택한 셀의 약이름으로 수정
        
        
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.hour = alarmTimes[receiveIndex!].hour!
        components.minute = alarmTimes[receiveIndex!].minute!
        datePicker.setDate(calendar.date(from: components)!, animated: true) //선택한 셀의 시간으로 수정
    }
    
    //키보드 사라지는 함수
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){
        medicineNameTextField.resignFirstResponder()
    }
    
    @IBAction func modifyCell(_ sender: UIButton) {
        medicineNames[receiveIndex!] = medicineNameTextField.text!
        alarmTimes[receiveIndex!].hour = datePickerHour
        alarmTimes[receiveIndex!].minute = datePickerMinute
        
        _ = navigationController?.popViewController(animated: true) //pop해서 뒤로감
   }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true) //pop해서 뒤로감
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        datePickerHour = sender.calendar.component(.hour, from: sender.date) //선택한 시간
        datePickerMinute = sender.calendar.component(.minute, from: sender.date) //선택한 분
    }
    
    //몇번째 셀을 선택했는지 index를 받는 함수
    func receiveSelectIndex(selectIndex:Int){
        receiveIndex = selectIndex
        
    }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
