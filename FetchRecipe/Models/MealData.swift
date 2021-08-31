//
//  MealData.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/31/21.
//

import Foundation

struct MealData: Decodable {
    let meals: [Meals]
}

struct Meals: Decodable {
    let strMeal: String
    let idMeal: String
}
