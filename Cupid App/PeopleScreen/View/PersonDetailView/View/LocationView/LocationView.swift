//
//  LocationView.swift
//  Cupid App
//
//  Created by Ngay Vong on 11/2/20.
//

import MapKit
import UIKit

class LocationView: UIView {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configUIData(withPerson person: Person) {
        guard let longitudeStr = person.location?.coordinates?.longitude,
              let longitude = Double(longitudeStr),
              let latitudeStr = person.location?.coordinates?.latitude,
              let latitude = Double(latitudeStr) else {
            return
        }
        
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        annotation.coordinate = coordinate
        annotation.title = person.address
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        mapView.setCenter(coordinate, animated: true)
        
        self.locationLabel.text = person.address
    }
}
