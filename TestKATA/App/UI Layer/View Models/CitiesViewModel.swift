//
//  CitiesViewModel.swift
//  TestKATA
//
//  Created by Moez bachagha on 9/10/2023.
//

import Foundation
class CitiesViewModel {
    private(set) var Cities: [City] = []
    private(set) var error: DataError? = nil
    private let apiService: CityAPILogic


    init(apiService: CityAPILogic = CityAPI() ) {
        self.apiService = apiService
    }

    func getCityDetails(lon : Double? , lat : Double? ,completion: @escaping( ([City]?, DataError?) -> () ) ) {
        apiService.getCityDetails(lon: lon, lat: lat,
            completion: { [weak self] result in
            switch result {
            case .success(let cities):
                self?.Cities = self?.Cities  ?? []
                completion(cities, nil)
            case .failure(let error):
                self?.error = error
                completion(nil, error)
            }
        })
    }



}
