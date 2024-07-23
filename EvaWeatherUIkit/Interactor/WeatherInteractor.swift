//
//  WeatherInteractor.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import Foundation


protocol WeatherInteractorInputProtocol: AnyObject {
    func fetchWeatherData(for city: String, latitude: Double, longitude: Double)
}

protocol WeatherInteractorOutputProtocol: AnyObject {
    func didFetchWeatherData(_ data: WeatherData.CurrentWeather, for city: String)
    func didFailToFetchWeatherData(for city: String, with error: Error)
}

class WeatherInteractor: WeatherInteractorInputProtocol {
    weak var presenter: WeatherInteractorOutputProtocol?

    func fetchWeatherData(for city: String, latitude: Double, longitude: Double) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,relative_humidity_2m,rain,visibility,wind_speed_10m"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.presenter?.didFailToFetchWeatherData(for: city, with: error)
                return
            }

            guard let data = data else { return }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                self.presenter?.didFetchWeatherData(weatherData.current, for: city)
               // print(weatherData.current)
            } catch {
                self.presenter?.didFailToFetchWeatherData(for: city, with: error)
            }
        }
        task.resume()
    }
}
