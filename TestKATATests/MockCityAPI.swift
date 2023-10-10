//
//  MockCityAPI.swift
//  TestKATATests
//
//  Created by Moez bachagha on 10/10/2023.
//


import Foundation
@testable import TestKATA

class MockCityAPI: CityAPILogic {


    var loadState: CityListLoadState = .empty

    func getCityDetails(lon: Double?, lat: Double?,  completion: @escaping (TestKATA.CityListAPIResponse)) {
        switch loadState {
        case .error:
            completion(.failure(.networkingError("Could not fetch cities")))
        case .loaded:
            let mockCity = City(coord: nil, weather:  [], base: "", main: nil, visibility: 1, wind: nil, clouds: nil, dt: 1, sys: nil, timezone: 1, id: 1, name: "test", cod: 10)
            completion(.success([mockCity]))
        case .empty:
            completion(.success([]))
        }
    }
}
