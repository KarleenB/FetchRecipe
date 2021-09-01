//
//  RecipeManager.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/30/21.
//

import Foundation

protocol RecipeInfoFetchDelegate: AnyObject {
    func didFetchRecipeInfo(with recipe: Recipe)
    func didFailWithError(_ error: Error)
}

protocol CategoryListFetchDelegate: AnyObject  {
    func didFetchCategoryList(with categoryData: CategoryData)
    func didFailWithError(_ error: Error)
}

protocol MealListFetchDelegate: AnyObject  {
    func didFetchMealsList(with mealData: MealData)
    func didFailWithError(_ error: Error)
}

struct NetworkManager {
    
    weak var categoryListFetchDelegate: CategoryListFetchDelegate?
    weak var mealListFetchDelegate: MealListFetchDelegate?
    weak var recipeInfoFetchDelegate: RecipeInfoFetchDelegate?
    
    let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    let recipeURL = "lookup.php?i=52772"
    
    // MARK: - Category List
    
    func getCategoryURL() -> String {
        "\(baseURL)categories.php"
    }
    
    func fetchCategoryList() {
        let urlString = getCategoryURL()
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.categoryListFetchDelegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let categoryFood = self.decodeCategoryList(categoryData: safeData) {
                        self.categoryListFetchDelegate?.didFetchCategoryList(with: categoryFood)
                    }
                }
            }
            task.resume()
        }
    }
    
    func decodeCategoryList(categoryData: Data) -> CategoryData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: categoryData)
            return decodedData
        } catch {
            return nil
        }
    }
    
    // MARK: - Meals List
    func getMealsURL(categoryName: String) -> String {
        return "\(baseURL)filter.php?c=\(categoryName)"
    }
    
    func fetchMealsList(categoryName: String) {
        let urlString = getMealsURL(categoryName: categoryName)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.mealListFetchDelegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let meal = self.decodeMealsList(mealData: safeData) {
                        self.mealListFetchDelegate?.didFetchMealsList(with: meal)
                    }
                }
            }
            task.resume()
        }
    }
    
    func decodeMealsList(mealData: Data) -> MealData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MealData.self, from: mealData)
            return decodedData
        } catch {
            return nil
        }
    }
    
    // MARK: - Recipe Info
    func getRecipeURL(mealID: String) -> String {
        return "\(baseURL)lookup.php?i=\(mealID)"
    }
    
    func fetchRecipeInfo(mealID: String) {
        let urlString = getRecipeURL(mealID: mealID)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.recipeInfoFetchDelegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let recipes = self.decodeRecipeInfo(recipeData: safeData),
                      let recipe = recipes.meals.first {
                        self.recipeInfoFetchDelegate?.didFetchRecipeInfo(with: recipe)
                        print(recipe)
                    }
                }
            }
            task.resume()
        }
    }
    
    func decodeRecipeInfo(recipeData: Data) -> RecipeData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            return decodedData
        } catch {
            return nil
        }
    }
}


