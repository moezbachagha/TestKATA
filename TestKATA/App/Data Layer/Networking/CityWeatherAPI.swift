//
//  CityWeatherAPI.swift
//  TestKATA
//
//  Created by Moez bachagha on 9/10/2023.
//

import Foundation
import Alamofire

typealias CityListAPIResponse = (Swift.Result<[City]?, DataError>) -> Void

// API interface to retrieve city

protocol CityAPILogic {
    func getCityDetails(lon : Double? , lat:Double?, completion: @escaping (CityListAPIResponse))
}

class CityAPI: CityAPILogic {



    func getCityDetails(lon : Double? , lat : Double?, completion: @escaping (CityListAPIResponse)) {


        var urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat!)&lon=\( lon!)&appid=\(Common.Global.apiKey)"
        var url = URL(string: urlString)


        AF.request(url! , method: .get, parameters: nil, encoding : URLEncoding.default, headers: Common.Global.headers)
            .validate()
            .responseDecodable(of: City.self) { response in
                print(response)

                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let cities):
                    completion(.success([cities]))
                }
            }



    }

}
