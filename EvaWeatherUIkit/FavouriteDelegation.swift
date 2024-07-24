//
//  FavouriteDelegation.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 24/07/2024.
//

import Foundation

protocol FavoriteCityDelegation {
    func didChangeFavoriteStatus(for city: String, isFavorite: Bool)
}
