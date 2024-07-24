//
//  weatherRouter.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import Foundation
import UIKit

protocol WeatherRouterProtocol: AnyObject {
    func navigateToWeatherDetail(from view: CitiesListViewProtocol, for city: String, with data: WeatherData.CurrentWeather)
}

class WeatherRouter: WeatherRouterProtocol {
    var favoriteCityDelegate: FavoriteCityDelegation?

    func navigateToWeatherDetail(from view: CitiesListViewProtocol, for city: String, with data: WeatherData.CurrentWeather) {
        guard let viewController = view as? UIViewController else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let weatherDetailVC = storyboard.instantiateViewController(withIdentifier: "CitiesDetailsViewController") as? CitiesDetailsViewController {
            weatherDetailVC.city = city
            weatherDetailVC.weatherData = data
            weatherDetailVC.delegate = favoriteCityDelegate

            viewController.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
}
