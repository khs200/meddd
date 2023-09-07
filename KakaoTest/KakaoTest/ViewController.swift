//
//  ViewController.swift
//  KakaoTest
//
//  Created by 한철희 on 2023/09/04.
//

import UIKit
import CoreLocation

public let DEFAULT_POSITION = MTMapPointGeo(latitude: 37.223254, longitude: 127.187928)
class ViewController: UIViewController, MTMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var subView: UIView!
    @IBOutlet var currentLocationButton: UIButton!
    
    var mapView: MTMapView!
    var locationManager : CLLocationManager!
    
    var la : Double!
    var lo : Double!
    
    @IBAction func currentLocationButtonIsTapped(_ sender: UIButton) {
        // 작동 확인용
        print("버튼이 클릭되었습니다.")
        mapView.currentLocationTrackingMode = .onWithoutHeading
        mapView.showCurrentLocationMarker = true
        print("기능이 작동되었습니다.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        la = locationManager.location?.coordinate.latitude
        lo = locationManager.location?.coordinate.longitude
        
        // barButtonItem에 searchBar 생성
        let mainSearchBar = UISearchBar(frame: CGRect(x: 0, y: 20, width: 310, height: 40))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainSearchBar)
        mainSearchBar.delegate = self
        
        
        // searchBar 꾸미기
        mainSearchBar.placeholder = "검색어를 입력하세요"
        mainSearchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal) // 돋보기 버튼 없애기
        mainSearchBar.layer.borderColor = UIColor.gray.cgColor
        mainSearchBar.layer.borderWidth = 2.0
        mainSearchBar.layer.cornerRadius = 10
        mainSearchBar.clipsToBounds = true
        mainSearchBar.backgroundColor = UIColor.white
//        mainSearchBar.obscuresBackgroundDuringPresentation = false
        
        mapView = MTMapView(frame: subView.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION), zoomLevel: 1, animated: true)
            
            mapView.showCurrentLocationMarker = true
            
            subView.addSubview(mapView)
//            subView.hideKeyboardWhenTappedAround()
            
        }
        
        
    }
}

extension ViewController:CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count-1]
        let longtitude: CLLocationDegrees = location.coordinate.longitude
        let latitude: CLLocationDegrees = location.coordinate.latitude
        
        // 위치정보를 한글로 변환
        let LocationNow = CLLocation(latitude: la, longitude: lo)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(LocationNow, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address:[CLPlacemark] = placemarks {
                print("현재 위치 파악")
                if let country : String = address.last?.country {print(country)}
                if let administrativeArea : String = address.last?.administrativeArea {print(administrativeArea)}
                if let locality : String = address.last?.locality {print(locality)}
                if let name: String = address.last?.name {print(name)}
                print("현재위치 출력 완료")
            }
        })
        
        
        
        // 사용자의 현재 위치에 마커 추가
        let marker = MTMapPOIItem()
        marker.itemName = "현재위치"
        marker.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: la, longitude: lo))
        marker.markerType = .yellowPin
        
        mapView.addPOIItems([marker])
        
        let poiltem1 = MTMapPOIItem()
        
        poiltem1.itemName = "회사"
        poiltem1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.223254, longitude: 127.187928))
        poiltem1.markerType = .redPin
        
        mapView.addPOIItems([poiltem1])
        
        // 위치 업데이트를 받았으므로 위치 관리자를 멈춤
        //        locationManager.stopUpdatingLocation()
    }
    
    func createPin(itemName:String, getla:Double, getlo:Double, markerType: MTMapPOIItemMarkerType) -> MTMapPOIItem{
        let poiltem = MTMapPOIItem()
        poiltem.itemName = "\(itemName)"
        poiltem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: getla, longitude: getlo))
        poiltem.markerType = markerType
        mapView.addPOIItems([poiltem])
        return poiltem
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { // 모(서리)따기
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
