//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [Sandwich]()
    var filteredSandwiches = [Sandwich]()
    
    let userDefaultsPersistence = UserDefaultsPersistenceStore(userDefaults: UserDefaults.standard)
    let coreDataPersistence = CoreDataPersistenceStore()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedRC: NSFetchedResultsController<Sandwich>!
    var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        checkIfFirstLaunch()
        
        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSandwiches()
    }
    
    func checkIfFirstLaunch() {
        if userDefaultsPersistence.loadData(key: K.isFirstLaunch) == nil {
            let sandwichesJSON = SandwichData.sandwichData()
            sandwichesJSON.forEach { sandwich in
                saveSandwich(sandwich)
            }
            userDefaultsPersistence.saveData(value: false, key: K.isFirstLaunch)
        } else {
            loadSandwiches()
        }
    }
    
    //MARK: - Data manipulation
    func saveSandwich(_ sandwich: SandwichData) {
        sandwiches.append(coreDataPersistence.saveData(sandwich))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadSandwiches() {
        sandwiches = coreDataPersistence.loadData()
    }
    
    //MARK: - Navigation
    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    
    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
        filteredSandwiches = sandwiches.filter { (sandwich: Sandwich) -> Bool in
            let doesSauceAmountMatch = sauceAmount == .any || sandwich.sauceAmount?.sauceAmountString == sauceAmount?.rawValue
            
            if isSearchBarEmpty {
                return doesSauceAmountMatch
            } else {
                return doesSauceAmountMatch && sandwich.name!.lowercased()
                    .contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        
        let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
        
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.image!)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.sauceAmount?.sauceAmountString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sandwich = sandwiches[indexPath.row]
            context.delete(sandwich)
            sandwiches.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            appDelegate.saveContext()
            tableView.reloadData()
        }
    }
    
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchBar.selectedScopeButtonIndex = userDefaultsPersistence.loadData(key: K.searchBarIndex) as? Int ?? 0
        let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        userDefaultsPersistence.saveData(value: selectedScope, key: K.searchBarIndex)
        let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![selectedScope])
        
        filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
}

