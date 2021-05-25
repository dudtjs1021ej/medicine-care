//
//  ViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/13.
//

import UIKit
import UserNotifications

class AddViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var chooseTimeLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var medicineTextField: UITextField!
    
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var datePickerHour: Int! //선택한 시간
    var datePickerMinute: Int! //선택한 분
    
    
    var alarmTableView: UITableView?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.layer.cornerRadius = 12
        addButton.layer.cornerRadius = 12
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture) //키보드 사라지게 함
        
        datePickerHour = datePicker.calendar.component(.hour, from: datePicker.date) //선택한 시간
        datePickerMinute = datePicker.calendar.component(.minute, from: datePicker.date) //선택한 분
    
    }
    
    //키보드 사라지는 함수
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){
        medicineTextField.resignFirstResponder()
    }
    
    //추가버튼을 누르면 cell이 추가되는 함수
    @IBAction func addTableCell(_ sender: UIButton) {
        medicineNames.append(medicineTextField.text!)
        medicineTextField.text = "" //텍스트필드 다시 아무것도 안친걸로 초기화
        
        var date = DateComponents()
        date.hour = datePickerHour
        date.minute = datePickerMinute
        alarmTimes.append(date) //datePicker로 입력한 시간,분 alarmTimes에 append
        
        medicineTake.append(false) //약을 복용하지 않은 것으로 넣음
        
        _ = navigationController?.popViewController(animated: true) //pop해서 뒤로감
    }
    
    
    @IBAction func cancelButtonTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true) //pop해서 뒤로감
    }
    
    //datePicker에서 선택한 시간과 분이 무엇인지 체크하는 함수
    @IBAction func dataPickerValueChanged(_ sender: UIDatePicker) {
        datePickerHour = sender.calendar.component(.hour, from: sender.date) //선택한 시간
        datePickerMinute = sender.calendar.component(.minute, from: sender.date) //선택한 분
    }
}


