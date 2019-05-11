//
//  ViewController.swift
//  countryREST
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var tableView: UITableView!
    var model = CountryNamesModel()
    let networkingManager = NetworkingManager()
    var searchBar = UISearchBar()
    var filteredTableData = [CountryName]()
    var resultSearchController = UISearchController()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        fetchData()
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
        tableView.reloadData()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    
    func fetchData(){
        networkingManager.getNames(success: {responseModel in
                self.model = responseModel
            
                self.tableView.reloadData()
                self.filteredTableData = self.model.names
            
        }, failure: { error in
            self.showErrorAlert(with: error)
            
        })
            tableView.reloadData()
            self.refreshControl.endRefreshing()
        
    }
    func showErrorAlert(with error: Error){
        let alert = UIAlertController(title: "Something went wrong.", message:
            "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
}
//search Bar extensions
extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating{
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
extension MainViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var code: String
        if(resultSearchController.isActive &&  resultSearchController.searchBar.text != ""){
            code = filteredTableData[indexPath.row].alpha3Code
            
        } else {
            code = model.names[indexPath.row].alpha3Code
        }
        
        networkingManager.getDetails(with: code, success: { (detailModel) in
            
            self.resultSearchController.dismiss(animated: true)
            self.resultSearchController.searchBar.text = ""
            self.navigationController?.pushViewController(DetailsViewController(model: detailModel), animated: true)
            
        }, failure: {error in
            self.showErrorAlert(with: error)
        })
    }
    
}
extension MainViewController: UITableViewDataSource{
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
