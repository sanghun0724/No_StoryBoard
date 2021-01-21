//
//  Poketmon.swift
//  PoketMonDict
//
//  Created by sangheon on 2021/01/21.
//

import Foundation

struct Poketmon:Codable {
    var name:String?
    var imageUrl:String?
    var id:Int?
    var weight:Int?
    var height:Int?
    var defense:Int?
    var attack:Int?
    var description:String?
    var type:String?
    var baseExperience:Int?
}
