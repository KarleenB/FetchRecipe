//
//  RecipeData.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/31/21.
//

import Foundation

//name, instruct , ingred, measure

struct RecipeData: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    let strMeal: String
    let strInstructions: String
    
    let strIngredient1,
        strIngredient2,
        strIngredient3,
        strIngredient4,
        strIngredient5,
        strIngredient6,
        strIngredient7,
        strIngredient8,
        strIngredient9,
        strIngredient10,
        strIngredient11,
        strIngredient12,
        strIngredient13,
        strIngredient14,
        strIngredient15,
        strIngredient16,
        strIngredient17,
        strIngredient18,
        strIngredient19,
        strIngredient20: String?
    
    let strMeasure1,
        strMeasure2,
        strMeasure3,
        strMeasure4,
        strMeasure5,
        strMeasure6,
        strMeasure7,
        strMeasure8,
        strMeasure9,
        strMeasure10,
        strMeasure11,
        strMeasure12,
        strMeasure13,
        strMeasure14,
        strMeasure15,
        strMeasure16,
        strMeasure17,
        strMeasure18,
        strMeasure19,
        strMeasure20: String?
    
    var ingredients: [String?] {
        return [strIngredient1, strIngredient2, strIngredient3, strIngredient4,
                strIngredient5, strIngredient6, strIngredient7, strIngredient8,
                strIngredient9, strIngredient10, strIngredient11, strIngredient12,
                strIngredient13, strIngredient14, strIngredient15, strIngredient16,
                strIngredient17, strIngredient18, strIngredient19, strIngredient20]
    }
    
    var measurements: [String?] {
        return [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
                strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
                strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
                strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20]
    }
    
    var ingredientAndMeasurment: [(String?, String?)] {
        return Array(zip(ingredients, measurements))
    }
    
    var filteredIngredients: [(String, String)] {
        return ingredientAndMeasurment.filter { (ingredient, measurement) in
            guard let ingredient = ingredient, let measurement = measurement else {
                return false
            }
            
            return !ingredient.isEmpty && !measurement.isEmpty
        }.map { ($0!, $1!) }
    }
}
