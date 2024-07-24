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
    @IBOutlet weak var temprtureLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    var delegate: FavoriteCityDelegation?
    var isFavorite: Bool = false
    var cityIndex: Int = 0

    var city: String?
    var weatherData: WeatherData.CurrentWeather?
    var presenter: CitiesListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        guard let weather = weatherData else { return }
        
        temprtureLabel.text = " \(Int(weather.temperature_2m))°C"
        humidityLabel.text = "Humidity: \(weather.relative_humidity_2m)%"
        rainLabel.text = "Rain: \(weather.rain)mm"
        visibilityLabel.text = "Visibility: \(weather.visibility) meters"
        windLabel.text = "Wind: \(weather.wind_speed_10m)m"

        
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        isFavorite = !isFavorite
        let favImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favBtn.setImage(favImage, for: .normal)
        delegate?.didChangeFavoriteStatus(for: city ?? "", isFavorite: isFavorite)
    }
    
    private func setBackground() {
            let backgroundImage = UIImage(named: "background")
            let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
            backgroundImageView.image = backgroundImage
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
            self.view.insertSubview(backgroundImageView, at: 0)
        }
    

}
