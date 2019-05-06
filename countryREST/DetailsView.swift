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
    
 //   var model: CountryDetailModel?
    @IBOutlet weak var name: UILabel!
    
        @IBOutlet weak var flagImage: WKWebView!
        
        @IBOutlet weak var map: MKMapView!
        //    convenience init(model: CountryDetailModel){
//        self.init()
//        self.model = model
//    }
//
//     func instanceFromNib(){
//        self.addSubview(UINib(nibName: "Details", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView)
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupUI()
//    }
//
//    func setupUI(){
//        name.text = model?.details?.name
//
//    }
}

