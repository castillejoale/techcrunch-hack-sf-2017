//
//  HomeViewController.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import UIKit
import Mapbox

class HomeViewController: UIViewController, MGLMapViewDelegate, UITableViewDelegate, UITableViewDataSource, RequestsControllerProtocol {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var requestsView: UIView!
    @IBOutlet weak var mapViewContainer: UIView!
    
    @IBOutlet weak var mapView: MQMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView?.mapType = .normal
//        mapView?.trafficEnabled = true
        mapView?.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Register custom cell
        self.tableView.register(UINib(nibName: "RequestTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //Add header view
        //        var header :TeamTableViewHeader?
        //        header = TeamTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height/30))
        //        self.tableView.tableHeaderView = header
        
        //Eliminate random header on tableView
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Eliminate extra cells
        self.tableView.tableFooterView = UIView()
        
        //Set separator color
        //        self.tableView.separatorColor = UIColor.gray1()
        
        //eliminate separator
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Round tableView
        //        self.tableView.layer.cornerRadius = 5.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        RequestsController.sharedInstance.getRequests()
        RequestsController.sharedInstance.delegate = self

        mapView.setCenter(CLLocationCoordinate2DMake(CLLocationDegrees(37.7749), CLLocationDegrees(-122.4100)), zoomLevel: 12.0, animated: true)
        
        self.refreshAnnotation()
        
    }
    
    
    func refreshAnnotation() {
        
        if let annotations = self.mapView.annotations {
            
            self.mapView.removeAnnotations(annotations)
            
        }
        
        if let requests = RequestsController.sharedInstance.getRequestsArray() {
            
            for request in requests {
                
                let annotation = CustomAnnotation()
                annotation.requestID = request.id
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(request.latitude), longitude: CLLocationDegrees(request.longitude))
                annotation.title = request.name
                annotation.subtitle = String(0.5) + " | " + request.dateCreated.getString()
                mapView.addAnnotation(annotation)
                
            }
            
        }
        
        self.tableView.reloadData()

    }

    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 80, height: 92)
            
            if let customAnnotationView = annotationView as? CustomAnnotationView {
                
                if let customAnnotation = annotation as? CustomAnnotation {
                    
                    if let request = RequestsController.sharedInstance.getRequest(id: customAnnotation.requestID) {
                        
                        customAnnotationView.updateView(request:request)
                        
                    }

                }
                
            }
            

            // Set the annotation view’s background color to a value determined by its longitude.
//            let hue = CGFloat(annotation.coordinate.longitude) / 100
//            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
            
//            annotationView.
//            annotationView.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: annotationView?.frame.height, right: 0))
            
        }
        
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        print("Annotation selected")
    }

    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        view.image = UIImage(named: "combinedShape.png")
        view.contentMode = .scaleAspectFit
        return view
        
    }
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        
        print("Callout tapped")
        
        if let customAnnotation = annotation as? CustomAnnotation {
            
            if let request = RequestsController.sharedInstance.getRequest(id: customAnnotation.requestID) {
                
                let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
                viewController.request = request
                self.navigationController?.present(viewController, animated: true, completion: nil)
                
            }
 
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
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            requestsView.isHidden = true
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            requestsView.isHidden = false
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let requests = RequestsController.sharedInstance.getRequestsArray() {
            
            return requests.count
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RequestTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! RequestTableViewCell
        
        if let requests = RequestsController.sharedInstance.getRequestsArray() {
            
            let request = requests[indexPath.row]
            
            cell.request = request
            
            cell.nameLabel.text = request.name
            cell.detailsLabel.text = "0.5mi" + " | " + request.dateCreated.getString()
            
            cell.emojisLabel.text = request.needs[0].description
            
            cell.selectionStyle = .none
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let currentCell = tableView.cellForRow(at: indexPath as IndexPath)! as? RequestTableViewCell {
            
            if let request = currentCell.request {
                
                let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
                viewController.request = request
                self.navigationController?.present(viewController, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    func getRequestsResponse(errors: [NSError]?) {
        if errors == nil {
            
            self.refreshAnnotation()
            
        }
    }

}
