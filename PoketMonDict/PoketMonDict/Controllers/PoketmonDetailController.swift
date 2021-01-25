//
//  PoketmonDetailController.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/25.
//

import UIKit

class PoketmonDetailController:UIViewController {
    
    //MARK: Properties
    var poketmon:Poketmon? {
        didSet {
            configurePoketmon()
        }
    }
    
    lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .mainColor
        return iv
    }()
    
    lazy var weightLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "WEIGHT"
        return label
    }()
    
    lazy var weightValueLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var underlineWeight:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        print("pretty good")
    }
    
    //MARK: Helper
    
    
    //MARK: Configuration
    func configurePoketmon() {
        guard let poketmon = self.poketmon else {
            return
        }
        self.title = poketmon.name?.uppercased()
        
        
    }
    
    func configureViewComponents() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        self.view.addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.topAnchor.constraint(equalTo:imageView.bottomAnchor,constant: 50).isActive = true
        weightLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 50).isActive = true
        weightLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -50).isActive = true
        
        self.view.addSubview(underlineWeight)
        underlineWeight.translatesAutoresizingMaskIntoConstraints = false
        underlineWeight.topAnchor.constraint(equalTo: weightLabel.bottomAnchor,constant: 5).isActive = true
        underlineWeight.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 50).isActive = true
        underlineWeight.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -50).isActive = true
        underlineWeight.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(weightValueLabel)
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
  
        
    }
    
}
