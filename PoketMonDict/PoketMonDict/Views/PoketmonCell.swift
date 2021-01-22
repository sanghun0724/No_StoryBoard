//
//  PoketmonCell.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/21.
//

import UIKit



class PoketmonCell:UICollectionViewCell {
    
    //MARK: Properties
    var poketmon:Poketmon? {
        didSet {
            guard let poketmon = self.poketmon else{
                return
            }
            self.poketmonName.text = poketmon.name
        }
    }
    lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.systemGroupedBackground
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var textView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.addSubview(self.poketmonName)
        poketmonName.translatesAutoresizingMaskIntoConstraints = false
        poketmonName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        poketmonName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
       return view
    }()
    
    lazy var poketmonName:UILabel = {
        let label = UILabel()
        label.text = "Dohhumon"
        label.font = UIFont.systemFont(ofSize: 14)
       return label
    }()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    func configureViewComponents() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true //뷰 초과해서 삐쭉나오는애들 잘라주기
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.7).isActive = true
        self.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
}
