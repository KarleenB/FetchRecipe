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
    
}
