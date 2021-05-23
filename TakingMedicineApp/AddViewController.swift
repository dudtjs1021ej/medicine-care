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
    
    
    var datePickerHour: Int! //선택한 시간
    var datePickerMinute: Int! //선택한 분
    
    let userNotificationCenter = UNUserNotificationCenter.current() //알림
    var alarmTableView: UITableView?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture) //키보드 사라지게 함
        
        
        requestNotificationAutorization() //알림 허가 받기
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true) //1초마다 타이머로 체크
        
        datePickerHour = datePicker.calendar.component(.hour, from: datePicker.date)
        datePickerMinute = datePicker.calendar.component(.minute, from: datePicker.date)
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){ //키보드 사라지는 함수
        medicineTextField.resignFirstResponder()
    }
    
    @IBAction func addTableCell(_ sender: UIButton) { //버튼을 누르면 cell이 추가되는 함수
        medicineNames.append(medicineTextField.text!)
        medicineTextField.text = "" //텍스트필드 다시 아무것도 안친걸로 초기화
        
        var date = DateComponents()
        date.hour = datePickerHour
        date.minute = datePickerMinute
        alarmTimes.append(date)
        
        _ = navigationController?.popViewController(animated: true) //pop해서 뒤로감
    }
    

    @IBAction func dataPickerValueChanged(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        chooseTimeLabel.text = format.string(from: sender.date)
        
        
        datePickerHour = sender.calendar.component(.hour, from: sender.date) //선택한 시간
        
        datePickerMinute = sender.calendar.component(.minute, from: sender.date) //선택한 분
        
        
        //sendNotification() //알림 보내기
        
//        print(datePickerHour)
//        print("--")
//        print(datePickerMinute)
    }
}

extension AddViewController{
    @objc func checkTime(){
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        currentTimeLabel.text = format.string(from: Date())
        sendNotification()
        
        if currentTimeLabel.text == chooseTimeLabel.text{ //선택한 시간이 현재 시간일 때
            //sendNotification()
            
        }
    }
}

extension AddViewController{
    func requestNotificationAutorization(){ //알림 권한 허용팝업
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                if let error = error {
                    print("Error: \(error)") //에러가 있으면 출력함
                }
            }
        
    }
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "제목"
        notificationContent.body = "\(datePickerHour!):\(datePickerMinute!)"
        
        var date = DateComponents()
        date.hour = datePickerHour
        date.minute = datePickerMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) //1초뒤에 알람가게 trigger설정
        
        
        let request = UNNotificationRequest(identifier: "test", content: notificationContent, trigger: trigger) //알람 요청
        
        userNotificationCenter.add(request){
            error in
            if let error = error{
                print("Notification Error:",error)
            }
        }
        
    }

}

//extension AddViewController{
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewController = segue.destination as! ViewController
//        if let tableView = viewController.alarmTableView{
//            alarmTableView = tableView
//        }
//    }
//}

//extension AddViewController{
//    override func viewWillAppear(_ animated: Bool) {
//
//        alarmTableView!.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//        index+=1
//    }
//}

//extension ViewController: UNUserNotificationCenterDelegate{
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                   didReceive response: UNNotificationResponse,
//                                   withCompletionHandler completionHandler: @escaping () -> Void) {
//           completionHandler()
//       }
//
//       func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                   willPresent notification: UNNotification,
//                                   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert,.badge,.sound])
//}
//}

