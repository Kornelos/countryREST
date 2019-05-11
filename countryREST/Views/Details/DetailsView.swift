//
//  DetailsView.swift
//  countryREST
//
//  Created by Kornel on 06/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit
import WebKit
import MapKit
    
    class DetailsView: UIView {
    
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var flagImage: WKWebView!
        @IBOutlet weak var map: MKMapView!
        @IBOutlet weak var region: UILabel!
        @IBOutlet weak var subregion: UILabel!
        @IBOutlet weak var capital: UILabel!
        @IBOutlet weak var area: UILabel!
        @IBOutlet weak var population: UILabel!
        @IBOutlet weak var languages: UILabel!
        @IBOutlet weak var currencies: UILabel!
        @IBOutlet weak var nativeName: UILabel!
        @IBOutlet weak var timezones: UILabel!
        @IBOutlet weak var mapActivityIndicator: UIActivityIndicatorView!
        
        func config(with details: CountryDetailModel){
            loadFlag(urlString: details.flag)
            centerMapOnLocation(CLLocation(latitude: details.latlng[0], longitude: details.latlng[1]), mapView: map, pinTitle: details.name)
            name.text = details.name
            region.text! += details.region
            subregion.text! += details.subregion
            capital.text! += details.capital
            nativeName.text! += details.nativeName
            area.text! += String(details.area) + "km²"
            population.text! += String(details.population)
            for currency in details.currencies{
                currencies.text! += " \(currency.name) [\(currency.symbol)],"
            }
            currencies.text!.removeLast()
            for language in details.languages{
                languages.text! += " \(language.name) [\(language.nativeName)],"
            }
            languages.text!.removeLast()
            for zone in details.timezones{
                timezones.text! += " \(zone),"
            }
            timezones.text!.removeLast()
        }
        //HTML code used for centering svg image inside WKWebView
        private func loadFlag(urlString: String){
        
                let html: String = """
                <html>
                <head>
                <style type="text/css">
                div{
                background:url(\(urlString)) no-repeat center center;
                background-size : contain;
                position: absolute;
                top: 0; right: 0; bottom: 0; left: 0;
                }
                </style>
                </head>
                <body>
                <div>
                </div>
                </body>
                </html>
                """
                flagImage.loadHTMLString(html, baseURL: URL(string: urlString))
        }
        private func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView, pinTitle: String?) {
            let regionRadius: CLLocationDistance = 1000000
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
            let pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            pin.title = pinTitle ?? ""
            mapView.addAnnotation(pin)
            
        }
}
