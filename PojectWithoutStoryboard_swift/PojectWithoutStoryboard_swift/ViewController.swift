//
//  ViewController.swift
//  PojectWithoutStoryboard_swift
//
//  Created by sangheon on 2021/01/18.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    private lazy var numberButton:UIButton = Utilities.shared.makeNumberButton(number: "1", numberColor: .white, backgroundColor: .systemGray2)
    
    
    private lazy var numberZeroButton:UIButton =  {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.widthAnchor.constraint(equalToConstant: 180).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bt.layer.cornerRadius = 40
        bt.backgroundColor = .systemGray2
        bt.tintColor = .white
        bt.setTitle("0", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 40,weight: UIFont.Weight.regular)
        bt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 100)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

      configureUI()
    }
    
    
    //MARK: - Configures
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(numberButton)
        numberButton.translatesAutoresizingMaskIntoConstraints = false //코드로 UI짯을때 동적으로 구현가능 하게 해줌
        numberButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        numberButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(numberZeroButton)
        numberZeroButton.translatesAutoresizingMaskIntoConstraints = false
        numberZeroButton.topAnchor.constraint(equalTo: numberButton.bottomAnchor,constant: 20).isActive = true
        numberZeroButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
    }
    
}

