//
//  WeatherViewModel.swift
//  Weather Test App
//
//  Created by Tanirbergen Kaldibai on 10.11.2021.
//

import Foundation


fileprivate protocol WeatherViewModelInputProtocol {
    var weatherData: Model? { get set }
}

protocol WeatherViewModelOutputProtocol {
    func fetchWeather()
}

protocol DidUpdateWeather {
    func didUpdateWeather()
}

final class WeatherViewModel: WeatherViewModelOutputProtocol, WeatherViewModelInputProtocol {
    
    // MARK: - Properties
    fileprivate(set) var weatherData: Model?
    var delegate: DidUpdateWeather?
    
    // MARK: - Injection
    private var networkManager: NetworkManager?
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension WeatherViewModel {
    func fetchWeather() {
        networkManager?.getLocationInfo(comp: { [weak self] (result) in
            guard let self = self else { return }
            self.weatherData = result
            self.delegate?.didUpdateWeather()
        })
    }
}
