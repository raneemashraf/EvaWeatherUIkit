//
//  CitiesTableViewController.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import UIKit

protocol CitiesListViewProtocol: AnyObject {
    func updateWeatherData(for city: String, with data: WeatherData.CurrentWeather)
    func showError(for city: String, with error: Error)
}


class CitiesTableViewController: UITableViewController, CitiesListViewProtocol,FavoriteCityDelegation {
   
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var presenter: CitiesListPresenterProtocol!
    var router: WeatherRouterProtocol!

    private var cities = ["Cairo", "Tokyo", "Madrid", "Lagos", "Moscow"]
    private var weatherData: [String: WeatherData.CurrentWeather] = [:]
    private var favorites: [String: Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CitiesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CitiesTableViewCell")
        
        let interactor = WeatherInteractor()
        let presenter = CitiesListPresenter()
        let router = WeatherRouter()
        
        self.presenter = presenter
        self.router = router

        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter as? WeatherInteractorOutputProtocol
        presenter.view = self
        fetchWeathers()
        router.favoriteCityDelegate = self
    }
    
    func didChangeFavoriteStatus(for city: String, isFavorite: Bool) {
        DispatchQueue.main.async {
            self.favorites[city] = isFavorite
            self.tableView.reloadData()
        }
    }
    
    
    func updateWeatherData(for city: String, with data: WeatherData.CurrentWeather) {
        DispatchQueue.main.async {
            print("Updating weather data for \(city) with \(data)")
            self.weatherData[city] = data
            self.tableView.reloadData()
        }
    }

    
    func showError(for city: String, with error: Error) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesTableViewCell") as! CitiesTableViewCell
        
        
        let city = cities[indexPath.row]
        
        cell.cityLabel.text = city
        if let weather = weatherData[city] {
                cell.tempLabel.text = "\(Int(weather.temperature_2m))°C"

            }
        print("Temp: \(weatherData[city]?.temperature_2m)°C")
        cell.favLabel.image = favorites[city] == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        if let weather = weatherData[city] {
            router.navigateToWeatherDetail(from: self, for: city, with: weather)
        }
    }

    private func fetchWeathers() {
        for (index, city) in cities.enumerated() {
            presenter.didSelectCity(at: index)
        }
    }
    
   
    
}
