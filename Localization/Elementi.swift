//
//  Elementi.swift
//  Localization
//
//  Created by Michele Manniello on 28/01/21.
//

import Foundation
import SwiftUI
import MapKit
//Now when precise location is not tuned on
class locationDelegate: NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var pins : [Pin] = []
//    checking autorization status...
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        were going to use only when in use key only
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("authorized..")
//            settings reduced accuracy to false...
//            and updating locations...
//            checkign Whether precise Location is turned on...
            if manager.accuracyAuthorization != .fullAccuracy{
                print("reduced Accuracy./...")
//                requesting remporay accuracy
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Location") { (err) in
                    if err != nil{
                        print(err!)
                        return
                    }
                }
            }
            manager.startUpdatingLocation()
        }else{
            print("not autorized..")
//            requestiong access
            manager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        pins.append(Pin(location: locations.last!))
    }
}
//Map pIns For Updates...
struct Pin: Identifiable {
    var id = UUID().uuidString
    var location : CLLocation
}
