//
//  ViewController.swift
//  countryREST
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  //  var tableViewBuilder: TableViewBuilder!
    var tableView: UITableView!
    let model = countriesModel()
   // let navBar = UINavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       // setNavigationBar()
        
        model.getNames(completion: {
            DispatchQueue.main.async{
            self.tableView.reloadData()
            }
        })
        
        
        
    }
    
    func setupUI(){
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        //tableView.backgroundColor = .blue
       
    }
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//        let navItem = UINavigationItem(title: "")
//
//        //let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(zone))
//       // navItem.rightBarButtonItem = doneItem
//       // navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        self.navigationController?.pushViewController(countryDetailsViewController(name: model.names[indexPath.row].alpha3Code), animated: true)
        
    }}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") ?? UITableViewCell(style: .default, reuseIdentifier: "")
        let text = model.names[indexPath.row].name
        cell.textLabel?.text = text
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
