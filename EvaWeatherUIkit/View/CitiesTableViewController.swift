//
//  CitiesTableViewController.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import UIKit

protocol CitiesListViewProtocol: AnyObject {
    func updateWeatherData(for city: String, with data: WeatherData.CurrentWeather)
    func updateFavoriteStatus(for city: String, isFavorite: Bool)
    func showError(for city: String, with error: Error)
}


class CitiesTableViewController: UITableViewController, CitiesListViewProtocol {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var presenter: CitiesListPresenterProtocol!
    
    private var cities = ["Cairo", "Tokyo", "Madrid", "Lagos", "Moscow"]
    private var weatherData: [String: WeatherData.CurrentWeather] = [:]
    private var favorites: [String: Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CitiesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CitiesTableViewCell")
        
        let interactor = WeatherInteractor()
        let presenter = CitiesListPresenter()
        self.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter as? WeatherInteractorOutputProtocol
        presenter.view = self
        fetchWeathers()
    }

    
    
    func updateWeatherData(for city: String, with data: WeatherData.CurrentWeather) {
        DispatchQueue.main.async {
            print("Updating weather data for \(city) with \(data)")
            self.weatherData[city] = data
            self.tableView.reloadData()
        }
    }


    
    func updateFavoriteStatus(for city: String, isFavorite: Bool) {
        favorites[city] = isFavorite
        tableView.reloadData()
    }
    
    func showError(for city: String, with error: Error) {
        // Handle error (e.g., show an alert)
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
                cell.tempLabel.text = "\(weather.temperature_2m)°C"
                print("Setting temp for \(city): \(weather.temperature_2m)°C")
            } else {
                cell.tempLabel.text = "Temp: N/A"
                print("No weather data for \(city)")
            }
        print("Temp: \(weatherData[city]?.temperature_2m)°C")
        return cell
    }

    // Handle row selection to navigate to the detailed weather screen
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let city = cities[indexPath.row]
            let weather = weatherData[city]

            // Instantiate the detail view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "CitiesDetailsViewController") as? CitiesDetailsViewController {
                // Pass data to the detail view controller
                detailVC.city = city
                detailVC.weatherData = weather
               // detailVC.isFavorite = favorites[city] ?? false
                
                // Push the detail view controller
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }

    private func fetchWeathers() {
        for (index, city) in cities.enumerated() {
            presenter.didSelectCity(at: index)
        }
    }
}
