//
//  countriesModel.swift
//  countryREST
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import Foundation

struct countryName: Decodable{
    let name: String
    let alpha3Code : String
}
class countriesModel{
    var names : [countryName] = []
    
    func getNames(completion: @escaping () -> ()){
        //Implementing URLSession
        let urlString = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {return} //unwrap
           
            do {
                self.names = try
                JSONDecoder().decode([countryName].self, from: data)
                
                
            } catch let jsonErr {
                print(jsonErr)
            }
            completion()
            }.resume()
        
    }
}
