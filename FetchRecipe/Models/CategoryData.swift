//
//  RecipeData.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/30/21.
//

import Foundation

struct CategoryData: Decodable {
    let categories: [Categories]
}

struct Categories: Decodable {
    let strCategory: String
}
 
