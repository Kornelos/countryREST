//
//  CountriesModel.swift
//  countryREST
//
//  Created by Kornel on 10/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import Foundation

struct CountryName: Codable{
    let name: String
    let alpha3Code : String
}
class CountryNamesModel{
    var names : [CountryName] = []
    
}
