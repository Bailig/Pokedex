//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-07.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//


import Alamofire
import SwiftyJSON

class Pokemon {
    
    private(set) var name: String = ""
    private(set) var id: Int = 0
    private(set) var requestUrl: String = ""
    private(set) var description: String = ""
    private(set) var type: String = ""
    private(set) var defense: String = ""
    private(set) var height: String = ""
    private(set) var weight: String = ""
    private(set) var attack: String = ""
    private(set) var evolText: String = "No Evolutions"
    private(set) var nextEvolLevel: Int = 0
    private(set) var nextEvolName: String = ""
    private(set) var nextEvolId: Int = 0
    
    convenience init(name: String, id: Int) {
        self.init()
        self.name = name.capitalized
        self.id = id
        self.requestUrl = UrlBuilder.pokemonRequestUrl(withId: id)
    }
    
    func requestDetailData(completeWith complete: @escaping () -> Void) {
        
        Alamofire.request(self.requestUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.weight = json["weight"].stringValue
                self.height = json["height"].stringValue
                self.attack = json["attack"].stringValue
                if json["evolutions"].arrayValue.count >= 1 {
                    if let evolName = json["evolutions"][0]["to"].string, !evolName.contains("mega") {
                        self.nextEvolName = evolName
                        var nextEvolId = json["evolutions"][0]["resource_uri"].stringValue
                        nextEvolId = nextEvolId.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: "")
                        self.nextEvolId = Int(nextEvolId)!
                        self.nextEvolLevel = json["evolutions"][0]["level"].intValue
                        self.evolText = "Next Evolution: \(self.nextEvolName) - LVL \(self.nextEvolLevel)"
                    }
                }
                self.defense = json["defense"].stringValue
                for type in json["types"].arrayValue {
                    if self.type == "" {
                        self.type = type["name"].stringValue.capitalized
                    } else {
                        self.type += "/\(type["name"].stringValue)".capitalized
                    }
                }
                let descriptionRequestUrl = "\(UrlBuilder.baseUrl)\(json["descriptions"][0]["resource_uri"].stringValue)"
                
                Alamofire.request(descriptionRequestUrl, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.description = json["description"].stringValue
                    case .failure(let error):
                        print(error)
                    }
                    
                    complete()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
