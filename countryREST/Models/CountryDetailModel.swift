//
//  CountryDetailModel.swift
//  countryREST
//
//  Created by Kornel on 10/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import Foundation

struct CountryDetailModel: Codable{
    let name: String
    let alpha3Code: String
    let capital: String
    let region: String
    let subregion: String
    let population: Int?
    let latlng: [Double]
    let area: Double?
    let timezones: [String]
    let nativeName: String
    let currencies: [Currency]
    let languages: [Language]
    let flag: String
    
}
struct Currency: Codable{
    let code: String
    let name: String
    let symbol: String
}
struct Language: Codable{
    let iso639_1: String
    let iso639_2: String
    let name: String
    let nativeName: String
}

