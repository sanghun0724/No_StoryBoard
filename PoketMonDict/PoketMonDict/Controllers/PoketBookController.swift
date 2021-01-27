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
    
    lazy var infoView:InfoView = {
        let view = InfoView()
        return view
    }()
    
    lazy var blurEffectView:UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
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
    @objc func blurViewTapped() {
        removeInfoViewAnimation()
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
    func navigationToDetailController(poketmon:Poketmon) {
        let poketmonDetailController = PoketmonDetailController()
        poketmonDetailController.poketmon = poketmon
        self.navigationController?.pushViewController(poketmonDetailController, animated: true)
    }
    
    func removeInfoViewAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
        self.infoView.removeFromSuperview()
    }
    
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
        
        collectionView.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        blurEffectView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        blurEffectView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        blurEffectView.alpha = 0
        
        let blurViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blurViewTapped))
        blurEffectView.addGestureRecognizer(blurViewTapGestureRecognizer)
    }
}

//MARK: collectionViewCell delegate func
extension PoketBookController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poketmons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poketmon = self.poketmons[indexPath.row]
        
        navigationToDetailController(poketmon: poketmon)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableIdentifier, for: indexPath) as! PoketmonCell
        
        let poketmon = self.poketmons[indexPath.row]
        cell.poketmon = poketmon
        cell.delegate = self
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

extension PoketBookController:PoketmonCellProtocol {
    func showPopup(poketmon: Poketmon) {
        self.view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.centerXAnchor.constraint(equalTo:collectionView.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor,constant: -55).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        infoView.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        infoView.delegate = self
        infoView.poketmon = poketmon
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 1
            self.infoView.transform = .identity
            self.infoView.alpha = 1
        })
    }
}

extension PoketBookController:InfoViewProtocol {
    func removeInfoView(poketmon:Poketmon) {
        removeInfoViewAnimation()
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3, execute: {
            self.navigationToDetailController(poketmon: poketmon)
        })
    }
    
    
    
}
