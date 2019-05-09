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
        
}
