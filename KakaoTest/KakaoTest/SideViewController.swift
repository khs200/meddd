//
//  SideViewController.swift
//  KakaoTest
//
//  Created by 한철희 on 2023/09/07.
//

import UIKit
import SafariServices

class SideViewController: UIViewController {
    
    @IBOutlet var policeButton: UIButton!
    @IBOutlet var firestationButton: UIButton!
    @IBOutlet var emergencyMedicalServiceButton: UIButton!
    
    // 응급상황 메뉴얼 조회
    @IBAction func emergencyManualTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.msdmanuals.com/ko-kr/%ED%99%88/%EC%9D%91%EA%B8%89%EC%83%81%ED%99%A9-%EB%B0%8F-%EC%86%90%EC%83%81") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    // 버튼을 눌렀을 때 전화 연결하기
    @IBAction func buttonTappedForCall(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            makePhoneCall(phoneNumber: "112")
        case 2:
            makePhoneCall(phoneNumber: "119")
        case 3:
            makePhoneCall(phoneNumber: "116117")
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // 전화 걸기 함수
    func makePhoneCall(phoneNumber: String) {
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                // 전화 앱을 열 수 없는 경우
                print("전화 앱을 열 수 없습니다.")
            }
        }
    }
    
    
}
