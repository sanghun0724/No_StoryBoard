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
    
    lazy var heightLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "HEIGHT"
        return label
    }()
    
    lazy var heightValueLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var lineUnderHeight:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    lazy var typeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "TYPE"
        return label
    }()
    
    lazy var typeValueLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var lineUnderType:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    lazy var defendLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "DEFENSE"
        return label
    }()
    
    lazy var defendValueLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var lineUnderDefend:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    
    lazy var attackLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "ATTACK"
        return label
    }()
    
    lazy var attackValueLabel:UILabel = {
       let label = UILabel()
        return label
    }()
    
    lazy var lineUnderAttack:UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        return view
    }()
    
    lazy var descriptionView:UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
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
        guard let imageUrl = poketmon?.imageUrl else {
            return
        }
        let url = URL(string: imageUrl)
        self.imageView.sd_setImage(with: url, completed: nil)
        guard let poketmon = self.poketmon else {
            return
        }
        self.title = poketmon.name?.uppercased()
        
        guard let weight = poketmon.weight else {
            return
        }
        
        self.weightValueLabel.text = String(weight)
        
        guard let height = poketmon.height else {
            return
        }
        self.heightValueLabel.text = String(height)
        
        guard let type = poketmon.type else {
            return
        }
        self.typeValueLabel.text = String(type).uppercased()
        
        guard let defend = poketmon.defense else {
            return
        }
        self.defendValueLabel.text = String(defend)
        
        guard let attack = poketmon.attack else {
            return
        }
        self.attackValueLabel.text = String(attack)
        
        guard let description = poketmon.description else {
            return
        }
        self.descriptionView.text = String(description)
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
        
        self.view.addSubview(underlineWeight)
        underlineWeight.translatesAutoresizingMaskIntoConstraints = false
        underlineWeight.topAnchor.constraint(equalTo: weightLabel.bottomAnchor,constant: 5).isActive = true
        underlineWeight.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 50).isActive = true
        underlineWeight.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -50).isActive = true
        underlineWeight.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(weightValueLabel)
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        weightValueLabel.leftAnchor.constraint(equalTo: weightLabel.rightAnchor, constant: 10).isActive = true
        weightValueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        
        self.view.addSubview(heightLabel)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor,constant: 20).isActive = true
        heightLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
       
        self.view.addSubview(heightValueLabel)
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20).isActive = true
        heightValueLabel.leftAnchor.constraint(equalTo: self.heightLabel.rightAnchor, constant: 10).isActive = true
        
        self.view.addSubview(lineUnderHeight)
        lineUnderHeight.translatesAutoresizingMaskIntoConstraints = false
        lineUnderHeight.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderHeight.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        lineUnderHeight.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        lineUnderHeight.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor,constant: 20).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
       
        self.view.addSubview(typeValueLabel)
        typeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        typeValueLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20).isActive = true
        typeValueLabel.leftAnchor.constraint(equalTo: self.typeLabel.rightAnchor, constant: 10).isActive = true
        
        self.view.addSubview(lineUnderType)
        lineUnderType.translatesAutoresizingMaskIntoConstraints = false
        lineUnderType.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderType.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        lineUnderType.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        lineUnderType.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(defendLabel)
        defendLabel.translatesAutoresizingMaskIntoConstraints = false
        defendLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor,constant: 20).isActive = true
        defendLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
       
        self.view.addSubview(defendValueLabel)
        defendValueLabel.translatesAutoresizingMaskIntoConstraints = false
        defendValueLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20).isActive = true
        defendValueLabel.leftAnchor.constraint(equalTo: self.defendLabel.rightAnchor, constant: 10).isActive = true
        
        self.view.addSubview(lineUnderDefend)
        lineUnderDefend.translatesAutoresizingMaskIntoConstraints = false
        lineUnderDefend.topAnchor.constraint(equalTo: defendLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderDefend.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        lineUnderDefend.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        lineUnderDefend.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(attackLabel)
        attackLabel.translatesAutoresizingMaskIntoConstraints = false
        attackLabel.topAnchor.constraint(equalTo: defendLabel.bottomAnchor,constant: 20).isActive = true
        attackLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
       
        self.view.addSubview(attackValueLabel)
        attackValueLabel.translatesAutoresizingMaskIntoConstraints = false
        attackValueLabel.topAnchor.constraint(equalTo: defendLabel.bottomAnchor, constant: 20).isActive = true
        attackValueLabel.leftAnchor.constraint(equalTo: self.attackLabel.rightAnchor, constant: 10).isActive = true
        
        self.view.addSubview(lineUnderAttack)
        lineUnderAttack.translatesAutoresizingMaskIntoConstraints = false
        lineUnderAttack.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderAttack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        lineUnderAttack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        lineUnderAttack.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
        self.view.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        descriptionView.topAnchor.constraint(equalTo: attackLabel.bottomAnchor,constant: 20).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -50).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 100).isActive = true
        
    }
    
}
