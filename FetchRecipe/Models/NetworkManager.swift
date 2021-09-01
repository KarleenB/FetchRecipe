//
//  RecipeManager.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/30/21.
//

import Foundation

protocol NetworkManagerDelegate {
    //func didUpdateList()
    func didFetchRecipeInfo(with: RecipeData)
    func didFetchCategoryList(with: CategoryData)
    func didFetchMealsList(with: MealData)
    func didFailWithError(_ error: Error)
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
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
                    self.delegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let categoryFood = self.decodeCategoryList(categoryData: safeData) {
                        self.delegate?.didFetchCategoryList(with: categoryFood)
                        print(categoryFood)
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
                    self.delegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let meal = self.decodeMealsList(mealData: safeData) {
                        self.delegate?.didFetchMealsList(with: meal)
                        print(meal)
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
    
    func fetchRecipeInfo(mealName: String) {
        let urlString = getRecipeURL(mealID: mealName)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error)
                }
                if let safeData = data {
                   if let recipe = self.decodeRecipeInfo(recipeData: safeData) {
                        self.delegate?.didFetchRecipeInfo(with: recipe)
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


