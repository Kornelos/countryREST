//
//  NetworkingManager.swift
//  countryREST
//
//  Created by Kornel on 10/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import Foundation

class NetworkingManager{
    
    func getNames(success: @escaping (_ model: CountryNamesModel) -> (),failure: @escaping (_ error: Error) -> ()){
        let urlString = "https://restcountries.eu/rest/v2/all"
        var names = [CountryName]()
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async{
                    failure(error!)
                }
            }
            guard let data = data else {return}
                
            do {
                names = try JSONDecoder().decode([CountryName].self, from: data)
                } catch let jsonErr {
                DispatchQueue.main.async{
                    failure(jsonErr)
                        }
                    }
            let model =  CountryNamesModel()
            model.names = names
            DispatchQueue.main.async{
                success(model)
            }
        }.resume()
        
        
    }
    
    func getDetails(with code: String, success: @escaping (_ model: CountryDetailModel) -> (),failure: @escaping (_ error: Error) -> ()){
        let urlString = "https://restcountries.eu/rest/v2/alpha/\(code)"
        guard let url = URL(string: urlString) else { return }
        var details: CountryDetailModel?
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async{
                    failure(error!)
                }
            }
            guard let data = data else {return}
                
            do {
                details = try JSONDecoder().decode(CountryDetailModel.self, from: data)
                DispatchQueue.main.async{
                success(details!)
                    }
                } catch let jsonErr {
                    DispatchQueue.main.async{
                        failure(jsonErr)
                    }
                    }
        }.resume()
    }
}
