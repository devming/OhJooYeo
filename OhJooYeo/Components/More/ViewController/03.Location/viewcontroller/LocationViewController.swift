//
//  LocationViewController.swift
//  OhJooYeo
//
//  Created by Minki on 07/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit
import NMapsMap

class LocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: NMFMapView!
    /// 돈암동감리교회
    /// 위도       경도
    /// 37.5978153 127.0149205
    static let segueName = "locationSegue"
    let donamCoordinate = NMGLatLng(lat: 37.5978153, lng: 127.0149205)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marker = NMFMarker(position: donamCoordinate)
        marker.mapView = mapView
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
}

extension LocationViewController: NMFAuthManagerDelegate {
    func authorized(_ state: NMFAuthState, error: Error?) {
        if error != nil {
            showConfirmationAlert(alertTitle: "지도 불러오기 에러", alertMessage: "지도 정보를 불러오는데 실패했습니다. Error code: \(state)", viewController: self)
        }
    }
}
