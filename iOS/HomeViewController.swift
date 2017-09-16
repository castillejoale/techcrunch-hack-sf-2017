//
//  HomeViewController.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import UIKit
import Mapbox

class HomeViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var mapView: MQMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.mapType = .normal
        
        
        
//        let sanFran = MGLPointAnnotation()
//        sanFran.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//        sanFran.title = "San Francisco"
//        sanFran.subtitle = "Welcome to San Fran"
//        mapView?.addAnnotation(sanFran)
//        mapView?.setCenter(sanFran.coordinate, zoomLevel: 10, animated: true)
        
//        mapView?.userTrackingMode = .follow
        
        mapView?.trafficEnabled = true
        
        mapView?.delegate = self
        
        let pisa = MGLPointAnnotation()
        pisa.coordinate = CLLocationCoordinate2D(latitude: 43.72305, longitude: 10.396633)
        pisa.title = "Leaning Tower of Pisa"
        pisa.subtitle = "ahsasdasafa"
        mapView.addAnnotation(pisa)

    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "pisa")
        
        if annotationImage == nil {
            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
            var image = UIImage(named: "pisa.png")!
            
            // The anchor point of an annotation is currently always the center. To
            // shift the anchor point to the bottom of the annotation, the image
            // asset includes transparent bottom padding equal to the original image
            // height.
            //
            // To make this padding non-interactive, we create another image object
            // with a custom alignment rect that excludes the padding.
            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            
            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "pisa")
        }
        
        return annotationImage
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }

}
