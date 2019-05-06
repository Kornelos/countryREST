//
//  countryDetailsViewController.swift
//  countryREST
//
//  Created by Kornel on 06/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit
import MapKit
class countryDetailsViewController: UIViewController {
    var name: String = ""
    var model:  CountryDetailModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        model = CountryDetailModel(code: name)
        
        model!.getDetails(completion: {
             DispatchQueue.main.async{
                if let view = Bundle.main.loadNibNamed("Details", owner: self, options: nil)?.first as? DetailsView{
                    view.name.text = self.model?.details?.name
                    do{
                    let svgString = try String(contentsOf: URL(string: (self.model?.details?.flag)!)!)
                    view.flagImage.loadHTMLString(svgString, baseURL: URL(string: (self.model?.details?.flag)!))
                    
                    } catch {print(error)}
                    let location = CLLocation(latitude: (self.model?.details?.latlng[0])!, longitude: (self.model?.details?.latlng[1])!)
                    self.centerMapOnLocation(location, mapView: view.map, pinTitle: self.model?.details?.name)
                    self.view.addSubview(view)
                }
                }
            
        })
        
     
    }
    convenience init(name: String) {
        self.init()
        self.name = name
        
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView, pinTitle: String?) {
        let regionRadius: CLLocationDistance = 1000000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        pin.title = pinTitle ?? ""
        mapView.addAnnotation(pin)
        
    }
    

}
