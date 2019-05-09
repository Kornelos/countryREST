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
        //TODO: animated "Loading..." text
        
        model = CountryDetailModel(code: name)
        
        model!.getDetails(completion: {
             DispatchQueue.main.async{
                if let view = Bundle.main.loadNibNamed("Details", owner: self, options: nil)?.first as? DetailsView{
                    guard let details = self.model?.details else {return}
                    view.name.text = details.name
                    do{
                    let svgString = try String(contentsOf: URL(string: details.flag)!)
                    view.flagImage.loadHTMLString(svgString, baseURL: URL(string: details.flag))
                    } catch {print(error)}
                    let location = CLLocation(latitude: details.latlng[0], longitude: details.latlng[1])
                    self.centerMapOnLocation(location, mapView: view.map, pinTitle: details.name)
                    view.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(view)
                    view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                    view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
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
