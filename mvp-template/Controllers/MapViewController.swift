//
//  MapViewController.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapViewController: UIViewController {
    
    //MARK: VARS
    
    var currentLocation: CLLocation?
    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    var isMoveToMarker = false
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view.addSubview(mapView)
    }

    func fetchAndShowRestarauntsWith(latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude , longitude: longitude, zoom: zoom)
        mapView.camera = camera
        
        Utilities.showHUD()
        
        AuthManager.shared.getAuthToken {[weak self] (accessToken) in
            
            let restaurantsModel = RestaurantsRequestModel(location: CLLocation(latitude: latitude, longitude: longitude), auth: accessToken, radius: Int(pow(256, 2) / zoom), offset : 0, limit: 50)
            RequestManager.addRequest(restaurantsModel).runWithHandler(RestauransHandler()) { (responce, error) in
                
                Utilities.hideHUD()
                
                if let responce = responce {
                    self?.mapView.clear()
                    
                    for restaurant in responce.restaurants {
                        let position = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longtitude)
                        if let weakSelf = self {
                            if weakSelf.mapView.projection.contains(position) {
                                let marker = GMSMarker()
                                marker.position = position
                                marker.userData = restaurant
                                marker.map = self?.mapView
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRestaurantDetail" {
            let destination = segue.destination as! RestaurantDetailViewController
            let marker = sender as! GMSMarker
            destination.restaurant = marker.userData as! Restaurant
        }
    }

}

extension MapViewController: GMSMapViewDelegate {
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if !isMoveToMarker {
            fetchAndShowRestarauntsWith(latitude: position.target.latitude, longitude: position.target.longitude, zoom: position.zoom)
        } else {
            isMoveToMarker = false
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        isMoveToMarker = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindowView: InfoWindowView = .fromNib()
        if let restaurant = marker.userData as? Restaurant {
            infoWindowView.nameLabel.text = restaurant.name
            infoWindowView.ratingStarView.value = CGFloat(restaurant.rating)
            infoWindowView.addressLabel.text = restaurant.address
        }
    

        return infoWindowView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.performSegue(withIdentifier: "toRestaurantDetail", sender: marker)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        locationManager.startUpdatingLocation()
        return false
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first!
        fetchAndShowRestarauntsWith(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: 16)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

