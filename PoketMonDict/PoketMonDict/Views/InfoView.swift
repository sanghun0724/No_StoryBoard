//
//  InfoView.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/24.
//

import UIKit
import SDWebImage

protocol InfoViewProtocol {
    func removeInfoView(poketmon:Poketmon)
}

class InfoView:UIView {
    //MARK:Properties
    var delegate:InfoViewProtocol?
    var poketmon:Poketmon? {
        didSet {
            configurePoketmon()
        }
    }
    
    lazy var nameView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        view.addSubview(self.nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "NAME"
        return label
    }()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
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
    
    lazy var lineUnderWeight:UIView = {
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
    
    lazy var goToDetailButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("상세보기", for: UIControl.State.normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .mainColor
        button.addTarget(self, action: #selector(goToDetailButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    //MARK: Init
    override init(frame:CGRect) {
        super.init(frame: frame)
        configureViewComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    @objc func goToDetailButtonTapped() {
        guard let poketmon = self.poketmon else {
            return
        }
        delegate?.removeInfoView(poketmon: poketmon)
    }
    
    //MARK: Override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adjustColors()
    }
    
    
    //MARK: Helper
    func configurePoketmon() {
        guard let poketmon = self.poketmon else { return }
        if let type = poketmon.type {
            self.typeValueLabel.text = String(type)
        }
        
        if let height = poketmon.height {
            self.heightValueLabel.text = String(height)
        }
        
        if let weight = poketmon.weight {
            self.weightValueLabel.text = String(weight)
        }
        self.nameLabel.text = poketmon.name
        if let urlString = poketmon.imageUrl {
            if let url = URL(string: urlString) {
                self.imageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    func adjustColors() {
        if self.traitCollection.userInterfaceStyle == .dark {
            //다크모드일떄
            self.goToDetailButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            // 화잍모드
            self.goToDetailButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            
        }
    }
    
    func configureViewComponent() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 16).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 50).isActive = true
        weightLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 50).isActive = true
       
        self.addSubview(weightValueLabel)
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        weightValueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        weightValueLabel.leftAnchor.constraint(equalTo: self.weightLabel.rightAnchor, constant: 10).isActive = true
        
        self.addSubview(lineUnderWeight)
        lineUnderWeight.translatesAutoresizingMaskIntoConstraints = false
        lineUnderWeight.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderWeight.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        lineUnderWeight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        lineUnderWeight.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.addSubview(heightLabel)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor,constant: 20).isActive = true
        heightLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 50).isActive = true
       
        self.addSubview(heightValueLabel)
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20).isActive = true
        heightValueLabel.leftAnchor.constraint(equalTo: self.heightLabel.rightAnchor, constant: 10).isActive = true
        
        self.addSubview(lineUnderHeight)
        lineUnderHeight.translatesAutoresizingMaskIntoConstraints = false
        lineUnderHeight.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderHeight.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        lineUnderHeight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        lineUnderHeight.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor,constant: 20).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 50).isActive = true
       
        self.addSubview(typeValueLabel)
        typeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        typeValueLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20).isActive = true
        typeValueLabel.leftAnchor.constraint(equalTo: self.typeLabel.rightAnchor, constant: 10).isActive = true
        
        self.addSubview(lineUnderType)
        lineUnderType.translatesAutoresizingMaskIntoConstraints = false
        lineUnderType.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        lineUnderType.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        lineUnderType.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        lineUnderType.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    
        self.addSubview(goToDetailButton)
        goToDetailButton.translatesAutoresizingMaskIntoConstraints = false
        goToDetailButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20).isActive = true
        goToDetailButton.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        goToDetailButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20).isActive = true
        goToDetailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        adjustColors()
        
        
        
        
    }
}
