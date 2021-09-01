//
//  CategoryListViewController.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/27/21.
//

import UIKit

class CategoryListViewController: UIViewController, CategoryListFetchDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var networkManager = NetworkManager()
    var tableViewData: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.categoryListFetchDelegate = self
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        categoryTableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "TableViewCell")
        
        networkManager.fetchCategoryList()
    }
    
    //MARK: - Category Delegate
    
    func didFetchCategoryList(with categoryData: CategoryData) {
        tableViewData = categoryData.categories.sorted(by: { $0.strCategory < $1.strCategory })
        DispatchQueue.main.async {
            self.categoryTableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.row].strCategory
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableViewData[indexPath.row]
        let viewController = MealViewController()
        viewController.category = category
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

