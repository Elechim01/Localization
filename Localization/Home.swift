//
//  Home.swift
//  Localization
//
//  Created by Michele Manniello on 28/01/21.
//

import SwiftUI
import MapKit
struct Home: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.784118, longitude: -122.406386), latitudinalMeters: 10000, longitudinalMeters: 10000)
    
    @State var traking : MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @StateObject var managerDelegate = locationDelegate()
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $traking, annotationItems: managerDelegate.pins) {  pin in
                MapPin(coordinate: pin.location.coordinate,tint: .red)
            }
        }.onAppear{
            manager.delegate = managerDelegate
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
//First with Full Accuracy.......
//Location Manager Delegate....
