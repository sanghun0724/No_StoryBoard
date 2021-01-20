//
//  Utilities.swift
//  PojectWithoutStoryboard_swift
//
//  Created by sangheon on 2021/01/18.
//

import UIKit

class Utilities {
    static let shared = Utilities() //굳이 딴데서 계속 객체 생성하지 않아도 여기서 한번생성하고 접근가능!
    
    func makeNumberButton(number:String,numberColor:UIColor,backgroundColor:UIColor) -> UIButton {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle(number, for: UIControl.State.normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 42,weight: .regular)
        bt.backgroundColor = backgroundColor
        bt.tintColor = numberColor
        bt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bt.layer.cornerRadius = 40
        return bt
    }
}
