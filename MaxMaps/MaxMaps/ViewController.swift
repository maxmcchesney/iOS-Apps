//
//  ViewController.swift
//  MaxMaps
//
//  Created by Michael McChesney on 2/2/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

// HOMEWORK
// - DONE - make the map view show your current location (not as an annotation, but as the blue dot)
// - DONE - make the "annotation view" show using "title" on an annotation (make the title be the name of the venue)
// - DONE - make the mapView zoom to the annotations (maybe look for a region
// - DONE - change the pin color


import UIKit
import MapKit
import CoreLocation

var onceToken: dispatch_once_t = 0

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var lManager = CLLocationManager()
    var mapView = MKMapView()
//    var venuesArray: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.frame = view.frame
        
        view.addSubview(mapView)
        
        lManager.requestWhenInUseAuthorization()
        
        lManager.delegate = self
        
        lManager.desiredAccuracy = kCLLocationAccuracyBest
        lManager.distanceFilter = kCLDistanceFilterNone
        
        lManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        dispatch_once(&onceToken) { () -> Void in
            
            if let location = locations.last as? CLLocation {
                
//                self.mapView.centerCoordinate = location.coordinate

                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                
                self.mapView.showsUserLocation = true
                
                self.mapView.setRegion(region, animated: true)
                
                // request to FourSquare for vendors with location
                let venues = FourSquareRequest.requestVenuesWithLocation(location)
                
                self.createAnnotationsWithVenues(venues)
                
//                TO ZOOM TO FIT ANNOTATIONS
                var annotationArray = self.mapView.annotations;
                self.mapView.showAnnotations(annotationArray, animated: true)
                
            }
        }
        
        lManager.stopUpdatingLocation()
    }
    
    
    
    
    func createAnnotationsWithVenues(venues: [AnyObject]) {

        for venue in venues as [[String:AnyObject]] {
            
            let annotationTitle = venue["name"] as String

            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees

            let long = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat, long)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(coordinate)
            
            annotation.title = annotationTitle  // SETS TITLE OF THE PIN
            
            mapView.addAnnotation(annotation)
 
        }

        
    }
    
    
//    CHANGES THE COLOR OF THE PIN
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

