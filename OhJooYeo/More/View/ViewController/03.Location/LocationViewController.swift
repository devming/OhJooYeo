//
//  LocationViewController.swift
//  OhJooYeo
//
//  Created by Minki on 07/02/2019.
//  Copyright © 2019 devming. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    var mapView: NMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = NMapView(frame: self.view.frame)
        
        if let mapView = mapView {
            
            // set the delegate for map view
            mapView.delegate = self
            mapView.reverseGeocoderDelegate = self
            
            // set the application api key for Open MapViewer Library
            mapView.setClientId("72axDGseEXGUjow0OWeU")
            
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(mapView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        mapView?.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView?.viewDidAppear()
        
        requestAddressByCoordination(NGeoPoint(longitude:127.0149708, latitude:37.5977458))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mapView?.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        mapView?.viewDidDisappear()
    }
    
    // MARK: -
    
    func requestAddressByCoordination(_ point: NGeoPoint) {
        mapView?.findPlacemark(atLocation: point)
        setMarker(point)
    }
    
    let UserFlagType: NMapPOIflagType = NMapPOIflagTypeReserved + 1
    
    func setMarker(_ point: NGeoPoint) {
        
        clearOverlay()
        
        if let mapOverlayManager = mapView?.mapOverlayManager {
            
            // create POI data overlay
            if let poiDataOverlay = mapOverlayManager.newPOIdataOverlay() {
                
                poiDataOverlay.initPOIdata(1)
                
                poiDataOverlay.addPOIitem(atLocation: point, title: "마커 1", type: UserFlagType, iconIndex: 0, with: nil)
                
                poiDataOverlay.endPOIdata()
            }
        }
    }
    
    func clearOverlay() {
        if let mapOverlayManager = mapView?.mapOverlayManager {
            mapOverlayManager.clearOverlay()
        }
    }
}

extension LocationViewController: NMapViewDelegate {
    
    // MARK: - NMapViewDelegate Methods
    
    open func onMapView(_ mapView: NMapView!, initHandler error: NMapError!) {
        if (error == nil) { // success
            // set map center and level
            mapView.setMapCenter(NGeoPoint(longitude:127.0149708, latitude:37.5977458), atLevel:13)
            // set for retina display
            mapView.setMapEnlarged(true, mapHD: true)
            // set map mode : vector/satelite/hybrid
            mapView.mapViewMode = .vector
        } else { // fail
            print("onMapView:initHandler: \(error.description)")
        }
    }
    
    open func onMapView(_ mapView: NMapView!, touchesEnded touches: Set<AnyHashable>!, with event: UIEvent!) {
        
        if let touch = event.allTouches?.first {
            // Get the specific point that was touched
            let scrPoint = touch.location(in: mapView)
            
            print("scrPoint: \(scrPoint)")
            print("to: \(mapView.fromPoint(scrPoint))")
            requestAddressByCoordination(mapView.fromPoint(scrPoint))
        }
    }
}

extension LocationViewController: NMapPOIdataOverlayDelegate {
    
    // MARK: - NMapPOIdataOverlayDelegate Methods
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, imageForOverlayItem poiItem: NMapPOIitem!, selected: Bool) -> UIImage! {
        return NMapViewResources.imageWithType(poiItem.poiFlagType, selected: selected);
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, anchorPointWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return NMapViewResources.anchorPoint(withType: poiFlagType)
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, calloutOffsetWithType poiFlagType: NMapPOIflagType) -> CGPoint {
        return CGPoint.zero
    }
    
    open func onMapOverlay(_ poiDataOverlay: NMapPOIdataOverlay!, imageForCalloutOverlayItem poiItem: NMapPOIitem!, constraintSize: CGSize, selected: Bool, imageForCalloutRightAccessory: UIImage!, calloutPosition: UnsafeMutablePointer<CGPoint>!, calloutHit calloutHitRect: UnsafeMutablePointer<CGRect>!) -> UIImage! {
        return nil
    }
}

extension LocationViewController: MMapReverseGeocoderDelegate {
    
    // MARK: - MMapReverseGeocoderDelegate Methods
    
    open func location(_ location: NGeoPoint, didFind placemark: NMapPlacemark!) {
//        let address = placemark.address
//
//        self.title = address
//
//        let alert = UIAlertController(title: "ReverseGeocoder", message: address, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
    
    open func location(_ location: NGeoPoint, didFailWithError error: NMapError!) {
        print("location:(\(location.longitude), \(location.latitude)) didFailWithError: \(error.description)")
    }
}
