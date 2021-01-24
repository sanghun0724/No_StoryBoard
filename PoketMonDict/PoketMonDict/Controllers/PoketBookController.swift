//
//  PoketbookController.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/20.
//

import UIKit

let reuseableIdentifier = "poketbookcell"

class PoketBookController:UICollectionViewController {
    //MARK: Properties
    let poketmonService = PoketmonService()
    var poketmons = [Poketmon]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy var infoView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    //MARK:Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
    }
    //MARK: override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // 디바이스의 테마가 변경될때마다 호출
        adjustColor()
    }
    
    //MARK: Selector
    @objc func searchTapped() {
        print(" 1")
    }
    
    func adjustColor() {
   
        if self.traitCollection.userInterfaceStyle == .dark {
            //다크모드일때
            navigationController?.navigationBar.tintColor = .white
        } else {
            //라이트모드일때
            navigationController?.navigationBar.tintColor = .black
        }
      
    }
    
   //MARK: Helper
    func configureViewComponent() {
        //systemColor -> Light 모드 다크모드 자동으로 바꿔줌 (추천)
        collectionView.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor =  UIColor.mainColor
        navigationController?.navigationBar.isTranslucent = false
        
        self.title = "포켓몬도감"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTapped))
        
        adjustColor()
        
        collectionView.register(PoketmonCell.self, forCellWithReuseIdentifier: reuseableIdentifier)
        poketmonService.fetchPoketmons()
        poketmonService.delegate = self
        
        collectionView.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.centerXAnchor.constraint(equalTo:collectionView.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor,constant: -55).isActive = true 
        
    }
}

//MARK: collectionViewCell delegate func
extension PoketBookController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poketmons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableIdentifier, for: indexPath) as! PoketmonCell
        
        let poketmon = self.poketmons[indexPath.row]
        cell.poketmon = poketmon
        return cell
    }
}
// MARK: UICollectionViewDelegateFlowLayout func
extension PoketBookController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
}

extension PoketBookController: PoketmonServiceProtocol {
    func poketmonService(poketmons: [Poketmon]) {
        print("asd")
        self.poketmons = poketmons
    }
    
    
}
