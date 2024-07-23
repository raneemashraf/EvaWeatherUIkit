//
//  CitiesDetailsViewController.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import UIKit

class CitiesDetailsViewController: UIViewController {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var TemprtureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    
    var city: String?
    var weatherData: WeatherData.CurrentWeather?
    var presenter: CitiesListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let weather = weatherData else { return }
        
        TemprtureLabel.text = "temp \(weather.temperature_2m)°C"
        humidityLabel.text = "Humidity: \(weather.relative_humidity_2m)%"
        rainLabel.text = "Rain: \(weather.rain)mm"
        visibilityLabel.text = "Visibility: \(weather.visibility) meters"
        windLabel.text = "Wind: \(weather.wind_speed_10m)m"

//        let isFavorite = presenter.fa(city: city ?? "")
//        favoriteButton.setTitle(isFavorite ? "Unfavorite" : "Favorite", for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
