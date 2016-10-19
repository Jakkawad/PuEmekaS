//
//  ViewController.swift
//  WakeMeUp
//
//  Created by admin on 10/19/2559 BE.
//  Copyright © 2559 Jakkawad.Chaiplee. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications
import AVFoundation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView:GMSMapView!
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
        mapView.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
//        self.locationManager.stopUpdatingLocation()
        
    }
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        print("didTapmarker")
//        return true
//    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("InfoMarker", owner: self, options: nil)?.first! as! InfoMarker
        infoWindow.lblName.text = "\(marker.position.latitude) \(marker.position.longitude)"
        return infoWindow
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapIndoWindowOfmarker")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Mark: \(coordinate.latitude), \(coordinate.longitude)")
        print("didTapAtcoordinate")
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        marker.title = "Mark1"
        marker.map = mapView
    }
    
//    func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
//        print("didStartTileRendering")
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
////        let location = mapView.myLocation
////        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
////        mapView.animate(to: camera)
////        let yourCurrentLocation = mapView.myLocation
////        print("youCurrentLocation: \(yourCurrentLocation)")
//        print("didUpdateHeading")
//    }
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        let location = mapView.myLocation
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
        mapView.animate(to: camera)
        let yourCurrentLocation = mapView.myLocation
        print("youCurrentLocation: \(yourCurrentLocation)")
        
    }
    
    // MARK: Notification
    func checkNotification() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: MapView
        self.mapView.delegate = self
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.compassButton = true
        
        // MARK: Location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

