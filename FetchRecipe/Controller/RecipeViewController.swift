//
//  RecipeViewController.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 9/1/21.
//

import UIKit

class RecipeViewController: UIViewController, RecipeInfoFetchDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var instructionLabel: UILabel!
    
    var meal: Meal!
    var networkManager = NetworkManager()
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        networkManager.recipeInfoFetchDelegate = self
        
        initializeInfoLabels()
        networkManager.fetchRecipeInfo(mealID: meal.idMeal)
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    //MARK: - Recipe Delegate
    
    func didFetchRecipeInfo(with recipe: Recipe) {
        self.recipe = recipe
        
        DispatchQueue.main.async {
            self.populateInfoLabels()
        }
    }
    
    func initializeInfoLabels() {
        titleLabel.text = ""
        ingredientsLabel.text = ""
        instructionLabel.text = ""
    }
    
    func populateInfoLabels() {
        titleLabel.text = recipe?.strMeal
        ingredientsLabel.text = createIngredientText()
        instructionLabel.text = recipe?.strInstructions
    }
    
    func createIngredientText() -> String? {
        guard let ingredientList = recipe?.filteredIngredients else { return nil }
        var ingredientText = ""
        for entry in ingredientList {
            ingredientText.append("\(entry.0): \(entry.1)\n")
        }
        return ingredientText
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}
