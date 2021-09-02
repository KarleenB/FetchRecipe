//
//  MealViewController.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 9/1/21.
//

import UIKit

class MealViewController: UITableViewController, MealListFetchDelegate {
   
    var category: Category!
    var networkManager = NetworkManager()
    var tableViewData: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category.strCategory
        
        networkManager.mealListFetchDelegate = self
        
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "TableViewCell")
        
        networkManager.fetchMealsList(categoryName: category.strCategory)
    }
    
    //MARK: - Meal Delegate
    
    func didFetchMealsList(with mealData: MealData) {
        tableViewData = mealData.meals.sorted(by: { $0.strMeal < $1.strMeal })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    //MARK: - Meal TableView Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath)
        cell.textLabel?.text = tableViewData[indexPath.row].strMeal
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = tableViewData[indexPath.row]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let recipeViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        recipeViewController.meal = meal
        
        navigationController?.pushViewController(recipeViewController, animated: true)
                
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


