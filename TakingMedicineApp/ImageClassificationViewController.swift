//
//  ImageClassificationViewController.swift
//  TakingMedicineApp
//
//  Created by 임영선 on 2021/05/24.
//

import UIKit
import Vision
import CoreML

class ImageClassificationViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var button: UIButton!
    

    @IBOutlet weak var takeLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var request: VNCoreMLRequest!
    var receiveIndex : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        
        myView.layer.cornerRadius = 12
        button.layer.cornerRadius = 12
       
        
        request = createCoreMLRequest(modelName: "MobileNetV2", modelExt: "mlmodelc", completionHandler: handleInageClassifier)
        if medicineTake[receiveIndex!] == true{
            takeLabel.text = "복용 완료"
            messageLabel.text = "오늘 \(medicineNames[receiveIndex!])을(를) 복용했습니다."
        }else{
            takeLabel.text = "복용 전"
            messageLabel.text = "컵 사진을 찍어 \(medicineNames[receiveIndex!]) 복용을 인증해주세요!"
            
        }
    }

    //인증 버튼을 눌렀을 때 실행되는 함수
    @IBAction func authenticateButton(_ sender: UIButton) {
       takePicture()
        
    }
    
    //몇번째 셀을 선택했는지 index를 받는 함수
    func receiveSelectIndex(selectIndex:Int){
        receiveIndex = selectIndex
        
    }
    
}

extension ImageClassificationViewController{
    @objc func takePicture(){

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera //카메라만을 사용
        }else{
            return
        }

        // UIImagePickerController이 활성화 된다
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImageClassificationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // 사진을 캡쳐하는 경우 호출 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 사진을 가져온다
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        
        let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
        try! handler.perform([request])
        picker.dismiss(animated: true, completion: nil)
    }

    // 사진 캡쳐를 취소하는 경우 호출 함수
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImageClassificationViewController{
    func createCoreMLRequest(modelName: String, modelExt:String, completionHandler: @escaping (VNRequest, Error?)->Void)->VNCoreMLRequest?{
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: modelExt) else{
            return nil
        }
        
        guard let vnCoreMLModel = try? VNCoreMLModel(for: MLModel(contentsOf: modelURL)) else{
            return nil
        }
        return VNCoreMLRequest(model: vnCoreMLModel, completionHandler: completionHandler)
    }
    
    func handleInageClassifier(request: VNRequest, error:Error?){
        guard let results = request.results as? [VNClassificationObservation] else{
            return
        }
        
        if let topResult = results.first{
            DispatchQueue.main.async {
                
                if topResult.identifier == "coffee mug"{
                    print("인증완료! :\(topResult.identifier) ")
                    self.resultLabel.text = "컵을 인식했습니다. 내일 또 인증해주세요!"
                    
                    print("cell \(self.receiveIndex!) 번째 인증 완료")
                    medicineTake[self.receiveIndex!] = true //인증 받은걸로 수정
                    self.takeLabel.text = "복용 완료"
                    self.messageLabel.text = "오늘 \(medicineNames[self.receiveIndex!])을(를) 복용했습니다."
                }
                else{
                    self.resultLabel.text = "컵을 인식하지 못했습니다. 다시 인증해주세요."
                }
            }
            
        }
    }
}
