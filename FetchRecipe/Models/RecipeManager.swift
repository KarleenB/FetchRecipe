//
//  RecipeManager.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/30/21.
//

import Foundation

struct RecipeManager {
    
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
        //Create URL
        if let url = URL(string: urlString) {
            
            //Create URL Session
            let session = URLSession(configuration: .default)
            
            //Give session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
            //Start task
            task.resume()
            
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
