//
//  countryDetailsViewController.swift
//  countryREST
//
//  Created by Kornel on 06/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit
import MapKit
import WebKit
class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    var model:  CountryDetailModel?
    var detailsView: DetailsView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let detailsView = Bundle.main.loadNibNamed("Details", owner: self, options: nil)?.first as? DetailsView else {return}
        detailsView.config(with: model!)
        detailsView.flagImage.navigationDelegate = self
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsView)
        detailsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        detailsView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.detailsView = detailsView

       }
    
    
    convenience init(model: CountryDetailModel) {
        self.init()
        self.model = model
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       detailsView?.mapActivityIndicator.stopAnimating()
    }
}
