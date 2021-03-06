//
//  PoketbookController.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/20.
//

import UIKit

let reuseableIdentifier = "poketbookcell"

class PoketBookController:UICollectionViewController {
    // 원래는 기본 ViewController로 처음시작으로 설정되어있음 so SceneDelegate 로 가서 이 CollectionViewr가 처음 시작할때 뜰수 있도록 설정해 줘야함 
    //MARK: Properties
    let poketmonService = PoketmonService()
    var poketmons = [Poketmon]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var searchPoketmons = [Poketmon]()
    var searchMode = false
        
    lazy var searchBar:UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.sizeToFit() //최대한 확장할수 있게끔
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
    }()
    
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
        // 디바이스의 테마가 변경될때마다 호출 (사용자가 설정을 건드려서 테마 바꿧을때! )
        adjustColor()  // <- 자동으로 적용되게
    }
    
    //MARK: Selector
    @objc func searchTapped() {
        configureSearchBar()
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
    func removeSearchBar() {
        self.navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTapped))
        adjustColor()
    }
    
    func configureSearchBar() {
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
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
        //systemColor -> Light 모드 다크모드 자동으로 바꿔줌 (추천) 영좋네!
        collectionView.backgroundColor = .systemBackground
        navigationController?.navigationBar.barTintColor =  UIColor.mainColor
        navigationController?.navigationBar.isTranslucent = false //navigationBar가 기본적으로 살짝투명효과가 있음  -> 컬러가 살짝 연하게 보임 -> false해줌으로써 원래색깔로
        
        self.title = "포켓몬도감"
        
        //검색 돋보기 만들기 SearchButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTapped))
        
        adjustColor() //처음 뷰만들어질때 한번 호출 
        
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
        if searchMode == false {
            return poketmons.count
        } else {
            return searchPoketmons.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poketmon:Poketmon?
        
        if searchMode == false {
             poketmon = self.poketmons[indexPath.row]
        } else {
            poketmon = self.searchPoketmons[indexPath.row]
        }
        if poketmon != nil {
            navigationToDetailController(poketmon: poketmon!)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableIdentifier, for: indexPath) as! PoketmonCell
        var poketmon:Poketmon?
        if searchMode == false {
            poketmon = self.poketmons[indexPath.row]
        } else {
            poketmon = self.searchPoketmons[indexPath.row]
        }
        
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

extension PoketBookController:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSearchBar()
        self.searchBar.text = ""
        searchMode = false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchPoketmons = [Poketmon]()
        if searchText == "" {
            searchMode = false
        } else {
            searchMode = true
            let matchingPoketmons = self.poketmons.filter{ (poketmon) -> Bool in
                guard let name = poketmon.name else { return false }
                return name.lowercased().contains(searchText.lowercased())
            }
            self.searchPoketmons = matchingPoketmons
        }
        
        collectionView.reloadData()
    }
}
