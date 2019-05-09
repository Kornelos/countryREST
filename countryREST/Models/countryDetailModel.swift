//
//  countryDetailModel.swift
//  countryREST
//
//  Created by Kornel on 06/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit

struct CountryDetail: Codable{
    let name: String
    //let topLevelDomain: [String]
    //let alpha2Code: String
    let alpha3Code: String
   // let callingCodes: [String]
    let capital: String
    //let altSpellings: [String]
    let region: String
    let subregion: String
    let population: Int
    let latlng: [Double]
   // let demonym: String
    let area: Double
    let timezones: [String]
    //let borders: [String]
    let nativeName: String
    //let numericCode: String
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

class CountryDetailModel{
    
    var details: CountryDetail?
    let urlString: String
    
    init(code: String) {
         urlString = "https://restcountries.eu/rest/v2/alpha/\(code)"
        
    }
    
    func getDetails(completion: @escaping () -> ()){
        //Implementing URLSession
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {return} //unwrap
            
            do {
                self.details = try
                    JSONDecoder().decode(CountryDetail.self, from: data)
                
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
             completion()
            
            }.resume()
        
       
}
}
