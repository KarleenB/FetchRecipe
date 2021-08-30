//
//  ViewController.swift
//  FetchRecipe
//
//  Created by Branden Karleen on 8/27/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let recipeManager = RecipeManager()
        
        recipeManager.fetchCategory()
    }


}

