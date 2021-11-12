//
//  NetworkManager.swift
//  Weather Test App
//
//  Created by Aibek on 29.10.2021.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getLocationInfo(comp: @escaping((Model) -> ()))
}

final class NetworkManager: NetworkManagerProtocol {
    
    
    func getLocationInfo(comp: @escaping ((Model) -> ())) {
        AF.request("https://api.weatherapi.com/v1/current.json?key=ce89d7a0ca2e42c98bd111736210311&q=Karaganda&aqi=no", method: .get).response {
            result in
            
            switch result.result {
            case .success(let data):
                do {
                    let res = try JSONDecoder().decode(Model.self, from: data!)
                    comp(res)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print("-------------------_>", err.localizedDescription)
            }
        }
    }
}
