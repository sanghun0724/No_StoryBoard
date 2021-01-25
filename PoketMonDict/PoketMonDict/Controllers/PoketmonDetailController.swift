//
//  PoketmonDetailController.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/25.
//

import UIKit

class PoketmonDetailController:UIViewController {
    
    //MARK: Properties
    var poketmon:Poketmon?
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        print("pretty good")
    }
    
    //MARK: Helper
    
    
    //MARK: Configuration
    func configurePoketmon() {
        
    }
    
    func configureViewComponents() {
        self.view.backgroundColor = .systemBackground
    }
    
}
