////
////  DataLoad.swift
////  KakaoTest
////
////  Created by 한철희 on 2023/09/07.
////
//
//import Foundation
//
//// API 엔드포인트 URL 생성
//let apiUrlString = "http://apis.data.go.kr/B552657/ErmctInsttInfoInqireService"
//
//// 인증 키 설정
//let apiKey = "EbsBCATzvQRNfGD46wZ8gm2e82JJpZlh2LWeJzjhr7%2Fqi2Tbe8s2VzvG%2BUGCL2bbZbIUq9DqZs1DD6xe3Nb5g%3D%3D"
//
//// URL 쿼리 매개변수 설정
//let endkey = "your_endkey_value"  // endkey 값 설정
//
//var components = URLComponents(string: apiUrlString)
//components?.queryItems = [
//    URLQueryItem(name: "ServiceKey", value: apiKey),  // 인증 키 설정
//    URLQueryItem(name: "endkey", value: endkey),
//    // 다른 필요한 매개변수 추가
//]
//
//if let url = components?.url {
//    var request = URLRequest(url: url)
//    
//    // HTTP 메서드 설정 (GET 또는 POST, API 문서를 확인하세요)
//    request.httpMethod = "GET"
//    
//    let session = URLSession.shared
//    let task = session.dataTask(with: request) { (data, response, error) in
//        if let error = error {
//            print("Error: \(error)")
//            return
//        }
//        
//        // 응답 상태 코드 확인
//        if let httpResponse = response as? HTTPURLResponse {
//            if httpResponse.statusCode == 200 {
//                print("데이터를 성공적으로 가져왔습니다.")
//            } else {
//                print("응답 상태 코드: \(httpResponse.statusCode)")
//            }
//        }
//        
//        if let data = data {
//            // 데이터를 처리하고 원하는 방식으로 파싱
//            // 예: JSON 파싱
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                // 여기에서 JSON 데이터를 처리하십시오.
//                print(json)
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
//    
//    // 네트워크 요청 시작
//    task.resume()
//}
