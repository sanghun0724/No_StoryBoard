//
//  InfoView.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/24.
//

import UIKit

class InfoView:UIView {
    //MARK:Properties
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
        print("iwaana go outside mofm")
    }
    
    //MARK: Override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adjustColors()
    }
    
    
    //MARK: Helper
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
        
        self.addSubview(goToDetailButton)
        goToDetailButton.translatesAutoresizingMaskIntoConstraints = false
        goToDetailButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20).isActive = true
        goToDetailButton.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        goToDetailButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20).isActive = true
        goToDetailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        adjustColors()
    }
}
