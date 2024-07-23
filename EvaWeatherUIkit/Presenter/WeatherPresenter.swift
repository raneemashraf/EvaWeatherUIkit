//
//  WeatherPresenter.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import Foundation

protocol CitiesListPresenterProtocol: AnyObject {
    func didSelectCity(at index: Int)
    func setCityFavorite(_ city: String, isFavorite: Bool)
}

class CitiesListPresenter: CitiesListPresenterProtocol {
    weak var view: CitiesListViewProtocol?
    var interactor: WeatherInteractorInputProtocol?
    
    private var cities = ["Cairo", "Tokyo", "Madrid", "Lagos", "Moscow"]
    private var favorites: [String: Bool] = [:]
    private var weathers: [String: WeatherData.CurrentWeather] = [:]

    func didSelectCity(at index: Int) {
        let city = cities[index]
        if let coordinates = getCityCoordinates(for: city) {
            interactor?.fetchWeatherData(for: city, latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    }

    func setCityFavorite(_ city: String, isFavorite: Bool) {
        favorites[city] = isFavorite
        view?.updateFavoriteStatus(for: city, isFavorite: isFavorite)
    }

    private func getCityCoordinates(for city: String) -> (latitude: Double, longitude: Double)? {
        switch city {
        case "Cairo": return (30.0444, 31.2357)
        case "Tokyo": return (35.6895, 139.6917)
        case "Madrid": return (40.4168, -3.7038)
        case "Lagos": return (6.5244, 3.3792)
        case "Moscow": return (55.7558, 37.6173)
        default: return nil
        }
    }
}

extension CitiesListPresenter: WeatherInteractorOutputProtocol {
    func didFetchWeatherData(_ data: WeatherData.CurrentWeather, for city: String) {
        print("Presenter: Fetched weather data for \(city): \(data)")
        weathers[city] = data
        if let view = view {
            view.updateWeatherData(for: city, with: data)
        }
    }


    func didFailToFetchWeatherData(for city: String, with error: Error) {
        view?.showError(for: city, with: error)
    }
}
