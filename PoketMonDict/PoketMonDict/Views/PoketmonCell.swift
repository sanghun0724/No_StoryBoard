//
//  PoketmonCell.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/21.
//

import UIKit



class PoketmonCell:UICollectionViewCell {
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
        self.backgroundColor = .tertiarySystemGroupedBackground
    }
}
