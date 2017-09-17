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
        mapView?.trafficEnabled = true
        mapView?.delegate = self
        
        let pisa = CustomAnnotation()
        pisa.id = 1
        pisa.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        pisa.title = "Leaning Tower of Pisa"
        pisa.subtitle = "ahsasdasafa jsfsdjk fbdsjkf bdsjfk dsbjkfd ahsasdasafa jsfsdjk fbdsjkf bdsjfk dsbjkfd "
        
        mapView.addAnnotation(pisa)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        let sanFran = MGLPointAnnotation()
//        sanFran.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        
        //        sanFran.title = "San Francisco"
        //        sanFran.subtitle = "Welcome to San Fran"
        //        mapView?.addAnnotation(sanFran)
        
//        mapView?.setCenter(sanFran.coordinate, zoomLevel: 10, animated: false)
        
//        mapView?.userTrackingMode = .follow
        
    }
    
//    // MARK: - MGLMapViewDelegate methods
//    
//    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        // This example is only concerned with point annotations.
//        guard annotation is MGLPointAnnotation else {
//            return nil
//        }
//        
//        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
//        let reuseIdentifier = "\(annotation.coordinate.longitude)"
//        
//        // For better performance, always try to reuse existing annotations.
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        // If there’s no reusable annotation view available, initialize a new one.
//        if annotationView == nil {
//            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
//            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            
//            // Set the annotation view’s background color to a value determined by its longitude.
//            let hue = CGFloat(annotation.coordinate.longitude) / 100
//            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
//        }
//        
//        
//        return annotationView
//        
//    }
    
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
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        print("Annotation selected")
    }
    
//    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
//        print("hey")
//    }
    
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = UIColor.red
        return view
    }
//
//    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
//        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
//        view.backgroundColor = UIColor.red
//        return view
//        
//    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        
        print("Callout tapped")
        
        if let customAnnotation = annotation as? CustomAnnotation {
            
            let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
            viewController.request = Request(id: customAnnotation.id)
            self.navigationController?.present(viewController, animated: true, completion: nil)
            
        }
        
    }
    
    //This method is necessary to have so the tapOnCalloutFor method is called!!!
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
//    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> UIView? {
//        
//        let view:UIView = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
//        view.backgroundColor = UIColor.red
//        return view
//    }

}
