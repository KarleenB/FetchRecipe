//
//  RecipeManager.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/30/21.
//

import Foundation

struct NetworkManager {
    
    let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    let categoryURL = "categories.php"
    
    //    //need to make sefood dynamic!!!!
    //    let mealsURL = "filter.php?c=Seafood"
    //
    //    //need to make id# dynamic!!!!!
    //    let recipeURL = "lookup.php?i=52772"
    
    
    func fetchCategory() {
        let urlString = "\(baseURL)\(categoryURL)"
        performRequest(urlString: urlString)
        
    }
    
    //    func fetchMeals() {
    //        let urlString = "\(baseURL)\(mealsURL)"
    //        performRequest(urlString: urlString)
    //    }
    //
    //    func fetchRecipe() {
    //        let urlString = "\(baseURL)\(recipeURL)"
    //        performRequest(urlString: urlString)
    //    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(recipeData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(recipeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: recipeData)
            print(decodedData.categories[0].strCategory)
        } catch {
            print(error)
        }
    }
    
}
