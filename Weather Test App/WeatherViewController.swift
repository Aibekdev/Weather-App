//
//  ViewController.swift
//  Weather Test App
//
//  Created by Aibek on 29.10.2021.
//
import Foundation
import UIKit
import CoreLocation
import Kingfisher

protocol UpdateWeather {
    func didUpdateWeather()
}

protocol WeatherViewInputProtocol {
    func fetchWeather()
}

protocol WeahterViewOutputProtocol {
    var weatherData: Model? { get set }
}

final class WeatherViewController: UIViewController, WeahterViewOutputProtocol {
    
    // MARK: - Properites
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    var weatherData: Model?
    var delegate: UpdateWeather?
    
    // MARK: - ViewModel
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

}

extension WeatherViewController: UpdateWeather {
    
    func updateView() {
        self.delegate = self
        fetchWeather()
    }
    
    func didUpdateWeather() {
        temperatureLabel.text = "\(weatherData?.current?.temp_c ?? 0.0)"
        conditionLabel.text = "\(weatherData?.current?.condition?.text ?? "Sun")"
        dayLabel.text = "\(weatherData?.location?.localtime ?? "Sunday")"
        
        
        
        guard let imageURL = URL(string: "https:\(weatherData?.current?.condition?.icon ?? "")" ) else {
            return
        }
        conditionImageView.kf.setImage(with: imageURL)
        
    }
    
    func fetchWeather() {
        networkManager.getLocationInfo { [weak self] (result) in
            guard let self = self else { return }
            self.weatherData = result
            self.delegate?.didUpdateWeather()
        }
    }
}
