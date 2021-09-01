//
//  ViewController.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/27/21.
//

import UIKit

class ViewController: UIViewController, NetworkManagerDelegate {
    
    var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        
        
        networkManager.fetchCategoryList()
    }
    
    
    func didFetchRecipeInfo(with: RecipeData) {
    
    }
    
    func didFetchMealsList(with: MealData) {
        
    }
    
    
    func didFetchCategoryList(with: CategoryData) {
        
    }
    
    func didFailWithError(_ error: Error) {
        
    }
    
 

}

