//
//  PoketmonService.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/21.
//

import Foundation

protocol PoketmonServiceProtocol {
    func poketmonService(poketmons:[Poketmon])
    
    
}

class PoketmonService {
    let url = "https://pokemon.treduler.pro/"
    var delegate:PoketmonServiceProtocol?
    
    func fetchPoketmons() {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data,respones,error) in
                if let error = error {
                    print("에러")
                    print(error.localizedDescription)
                } else {
                    if let data = data {
                        do {
                            let poketmons = try JSONDecoder().decode([Poketmon].self, from: data)
                            DispatchQueue.main.async {
                                self.delegate?.poketmonService(poketmons: poketmons)
                            }
                        } catch let error {
                            print("데이터업서요")
                            print(error.localizedDescription)
                        }
                    }
                }
                
            }.resume()
        }
    }
}
