//
//  ViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/20.
//

import UIKit

var medicineNames = ["약이름을 입력해주세요"] //약이름 배열
var date = DateComponents(hour:0, minute: 0)
var alarmTimes = [date] // 복용시간 배열
var alarmNum = 1

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var alarmTableView: UITableView!
    let userNotificationCenter = UNUserNotificationCenter.current() //알림
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userNotificationCenter.delegate = self
        
        alarmTableView.rowHeight = 100 //tableView 높이를 100으로
        alarmTableView.layer.cornerRadius = 12.0 //tableView를 둥글게
        alarmTableView.dataSource = self
        
        requestNotificationAutorization() //알림 허가 받기
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkAddAlarm), userInfo: nil, repeats: true) //1초마다 알람이 추가 되었는지 체크
    }

}

extension ViewController{
    
    //뷰가 나타날때마다 테이블뷰를 다시 로드하는 함수
    override func viewWillAppear(_ animated: Bool) {
        alarmTableView.reloadData() //테이블뷰 reload
    }
}

extension ViewController:UITableViewDelegate{
    
}

//tableView DataSource
extension ViewController:UITableViewDataSource{
    
    //셀 개수 리턴 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineNames.count
    }
    
    //셀 추가 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell",for: indexPath) as! TableViewCell
        cell.medicineNameLabel.text = medicineNames[(indexPath as NSIndexPath).row] //textLabel은 약 이름
       
        let alarmTime = alarmTimes[(indexPath as NSIndexPath).row]
        let alarmTimeString = "\(String(alarmTime.hour!))시  \(String(alarmTime.minute!))분"
        cell.alarmTimeLabel.text = alarmTimeString
       // sendNotification(index: (indexPath as NSIndexPath).row) //알람을 보냄
        return cell
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300.0
//    }
}




extension ViewController{
    @objc func checkAddAlarm(){
//        for i in 0..<alarmTimes.count{
//            if i != 0{ //첫번째 셀은 예시이므로 무시
//                let format = DateFormatter()
//                format.dateFormat = "H:m"
//                let currentTime = format.string(from: Date())
//                let alarmTime = "\(alarmTimes[i].hour!):\(alarmTimes[i].minute!)"
//                print("currentTime:\(currentTime) alarmTime:\(alarmTime)")
//                if currentTime == alarmTime{ //현재시간이 알람을 설정해둔 시간이면 알람을 보냄
//                    sendNotification(index: i)
//                }
//            }
//
//
//        }
    
//
       
        let alarmCount = medicineNames.count
       // print("alarmNum : \(alarmNum) alarmCount : \(alarmCount)")
        if alarmNum != alarmCount{
            sendNotification(index: alarmNum)
        }
        
   }
}

extension ViewController{
    
    //알림 권한 허용팝업 띄우는 함수
    func requestNotificationAutorization(){
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                if let error = error {
                    print("Error: \(error)") //에러가 있으면 출력함
                }
            }
        
    }
    //알람을 보내는 함수
    func sendNotification(index:Int){
        
        if index != 0{ //첫번째는 알람은 예시이므로 무시
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "약 복용 알림"
            notificationContent.body = "\(alarmTimes[index].hour!)시 \(alarmTimes[index].minute!)분에 \(medicineNames[index])을(를) 드실 시간이에요!"
            notificationContent.badge = 1 //알람 숫자 쌓이게함

          

            let trigger = UNCalendarNotificationTrigger(dateMatching: alarmTimes[index], repeats: false)
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) //1초뒤에 알람가게 trigger설정


            print("\(alarmNum) : \(String(alarmTimes[index].hour!))시 \(String(alarmTimes[index].minute!))분 알람 예정 ")
            let request = UNNotificationRequest(identifier: "alarmRequest\(alarmNum)", content: notificationContent, trigger: trigger) //알람 요청 (알람을 구분하기 위해 identifier를 다르게 설정)
            alarmNum+=1

            userNotificationCenter.add(request){
                error in
                if let error = error{
                    print("Notification Error:",error)
                }
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound])
    }
}


class AppDelate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let index = self.alarmTableView.indexPath(for: cell)
            let detailViewController = segue.destination as! DetailViewController
            let selectIndex = ((index as NSIndexPath?)?.row)!
            detailViewController.receiveMedicineNameTime(selectIndex:selectIndex)
             //detailViewController로 선택한 셀의 index를 보냄
        }
    }
}


