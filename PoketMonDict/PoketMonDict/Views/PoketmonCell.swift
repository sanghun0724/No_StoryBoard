//
//  PoketmonCell.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/21.
//

import UIKit
import SDWebImage

protocol PoketmonCellProtocol {
    func showPopup(poketmon:Poketmon)
}


class PoketmonCell:UICollectionViewCell {
    
    //MARK: Properties
    var delegate:PoketmonCellProtocol?
    
    var poketmon:Poketmon? {
        didSet {
            guard let poketmon = self.poketmon else{
                return
            }
            self.poketmonName.text = poketmon.name
            guard let imageUrl = self.poketmon?.imageUrl else { return }
            if let url = URL(string:  imageUrl) {
                self.imageView.sd_setImage(with: url, completed: nil)
                // 라이브러리 기능으로 캐시까지 기능 함
            }
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
    
    //MARK: Selector
    @objc func longPress(sender:UILongPressGestureRecognizer) {
       
        if sender.state == UIGestureRecognizer.State.began {
            guard let poketmon = self.poketmon else { return }
            delegate?.showPopup(poketmon:poketmon)
        }
    }
    
    //MARK: Helpers
    func configureViewComponents() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true //뷰 초과해서 삐쭉나오는애들 잘라주기
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        self.addGestureRecognizer(longPressRecognizer)
        
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
