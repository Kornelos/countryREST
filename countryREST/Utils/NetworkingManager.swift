//
//  NetworkingManager.swift
//  countryREST
//
//  Created by Kornel on 10/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import Foundation

class NetworkingManager{
    
    func getNames(completion: @escaping (_ model: CountryNamesModel) -> ()){
        //Implementing URLSession
        let urlString = "https://restcountries.eu/rest/v2/all"
        var names = [CountryName]()
        guard let url = URL(string: urlString) else { return }
        if Reachability.isConnectedToNetwork() == true{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else {return} //unwrap
                
                do {
                    names = try JSONDecoder().decode([CountryName].self, from: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
                let model =  CountryNamesModel()
                model.names = names
                completion(model)
                }.resume()
        }
        
    }
    
    func getDetails(with code: String, completion: @escaping (_ model: CountryDetailModel) -> ()){
        //Implementing URLSession
        let urlString = "https://restcountries.eu/rest/v2/alpha/\(code)"
        guard let url = URL(string: urlString) else { return }
        var details: CountryDetailModel?
        if Reachability.isConnectedToNetwork() == true{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else {return} //unwrap
                
                do {
                   details = try JSONDecoder().decode(CountryDetailModel.self, from: data)
                    completion(details!)
                } catch let jsonErr {
                    print(jsonErr)
                }
                
                
                
                }.resume()
        }
        
    }
}
