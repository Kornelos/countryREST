//
//  ViewController.swift
//  countryREST
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    let model = countriesModel()
    var searchBar = UISearchBar()
    var filteredTableData = [countryName]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Countries"
        setupTableView()
        setupSearchBar()
        model.getNames(completion: {
            DispatchQueue.main.async{
            self.tableView.reloadData()
                self.filteredTableData = self.model.names
            }
        })
    }
    
    func setupSearchBar(){
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
    
    }
    func setupTableView(){
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }


}
//search Bar extensions
extension ViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        var countries = [String]()
        for country in model.names{
            countries.append(country.name)
        }
        let array = (countries as NSArray).filtered(using: searchPredicate) as! [String]
        for country in model.names{
            if array.contains(where: {$0 == country.name}){
                filteredTableData.append(country)
            }
        }
        
        self.tableView.reloadData()    }
}
//Table View extensions
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(resultSearchController.isActive &&  resultSearchController.searchBar.text != ""){
            resultSearchController.dismiss(animated: true)
            self.navigationController?.pushViewController(countryDetailsViewController(name: filteredTableData[indexPath.row].alpha3Code), animated: true)
            
        } else {
            resultSearchController.dismiss(animated: true)
            self.navigationController?.pushViewController(countryDetailsViewController(name: model.names[indexPath.row].alpha3Code), animated: true)
            
        }
       resultSearchController.searchBar.text = ""
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            return filteredTableData.count
      
        } else {
            return model.names.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") ?? UITableViewCell(style: .default, reuseIdentifier: "")
        if (resultSearchController.isActive && resultSearchController.searchBar.text != "") {
            cell.textLabel?.text = filteredTableData[indexPath.row].name
            
            return cell
        } else {
        let text = model.names[indexPath.row].name
        cell.textLabel?.text = text
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.accessoryType = .disclosureIndicator
            return cell}
    }
    
    
}
