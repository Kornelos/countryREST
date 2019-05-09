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
    var detailsView: DetailsView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = CountryDetailModel(code: name)
        
        view.backgroundColor = .white
        detailsView = Bundle.main.loadNibNamed("Details", owner: self, options: nil)?.first as? DetailsView
       
        if !getData(for: detailsView!){
            refreshButton()
        }
        
        }
    
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    func refreshButton(){
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.center = view.center
        button.backgroundColor = .blue
        button.setTitle("Refresh", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    @objc func buttonAction(sender: UIButton!) {
        if getData(for: detailsView!){
            sender.removeFromSuperview()
        }
        
    }
    func getData(for detailsView: DetailsView)->Bool{
        var status: Bool = false
        model!.getDetails(completion: {
            DispatchQueue.main.async{
                guard let details = self.model?.details else {
                    print("Model empty")
                    return}
                self.fillDataFromModel(view: detailsView, details: details)
                detailsView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(detailsView)
                detailsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                detailsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                detailsView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                do{
                    let svgString = try String(contentsOf: URL(string: details.flag)!)
                    detailsView.flagImage.loadHTMLString(svgString, baseURL: URL(string: details.flag))
                } catch {print(error)}
                let location = CLLocation(latitude: details.latlng[0], longitude: details.latlng[1])
                self.centerMapOnLocation(location, mapView: detailsView.map, pinTitle: details.name)
                status = true
            }
            
        })
        return status
    }
    func fillDataFromModel(view: DetailsView, details: CountryDetail){
        view.name.text = details.name
        view.region.text! += details.region
        view.subregion.text! += details.subregion
        view.capital.text! += details.capital
        view.nativeName.text! += details.nativeName
        view.area.text! += String(details.area) + "km²"
        view.population.text! += String(details.population)
        for currency in details.currencies{
            view.currencies.text! += " \(currency.name) [\(currency.symbol)],"
        }
        view.currencies.text!.removeLast()
        for language in details.languages{
            view.languages.text! += " \(language.name) [\(language.nativeName)],"
        }
        view.languages.text!.removeLast()
        for zone in details.timezones{
            view.timezones.text! += " \(zone),"
        }
        view.timezones.text!.removeLast()
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
