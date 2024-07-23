//
//  ViewController.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 22/07/2024.
//

import UIKit

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToCitiesList()
        }
    }

    private func navigateToCitiesList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let citiesListVC = storyboard.instantiateViewController(withIdentifier: "CitiesTableViewController") as? CitiesTableViewController {
            self.navigationController?.pushViewController(citiesListVC, animated: true)
        }
    }
}
