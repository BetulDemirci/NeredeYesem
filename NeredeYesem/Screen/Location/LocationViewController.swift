//
//  LocationViewController.swift
//  NeredeYesem
//
//  Created by Semafor Teknolojı on 24.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet weak var actionAllowButon: UIButton!
    @IBOutlet weak var actionDennyButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    let locationManager = CLLocationManager()
    let location: CLLocation? = nil
     let locationService = LocationService()
   override func viewDidLoad() {
          super.viewDidLoad()
      getCurrrentLocation()
    }
    

    @IBAction func actionAllowLocationButton(_ sender: UIButton) {
        
       /*locationService.didChangeStatus = { [weak self] success in
                  if success {
                      self?.locationService.getLocation()
                    self!.performSegue(withIdentifier: "goHomePage", sender: self)
                  }
              }*/
        switch locationService.status {
           case .notDetermined:
              locationManager.requestWhenInUseAuthorization()
           return
           case .denied, .restricted:
              let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
              present(alert, animated: true, completion: nil)
           return
           case .authorizedAlways, .authorizedWhenInUse:
           break
        }
            locationService.requestLocationAuthorization()
                  locationManager.startUpdatingLocation()
            locationService.didChangeStatus = { [weak self] success in
                if success {
                    self?.locationService.getLocation()
                  self!.performSegue(withIdentifier: "goHomePage", sender: self)
                }
            }
    }
    
    @IBAction func actionDennyLocationButton(_ sender: UIButton) {
       //go to url web site
    }
    
 
    func getCurrrentLocation(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.performSegue(withIdentifier: "goHomePage", sender: self)
    }
}
