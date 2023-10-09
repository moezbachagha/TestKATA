//
//  City.swift
//  TestKATA
//
//  Created by Moez bachagha on 9/10/2023.
//


import Foundation

struct City: Decodable {
    let coord: coord?
    let weather: [weather]?
    let base: String?
    let main: main?
    let visibility: Int?
    let wind: wind?
    let clouds: clouds?
    let dt: Int?
    let sys: sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?



    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod

}
}
struct coord: Decodable {

    let lon: Double?
    let lat: Double?


    enum CodingKeys: String, CodingKey {
        case lon
        case lat


}
}
struct weather: Decodable {

    let id: Int?
    let main: String?
    let description: String?
    let icon: String?



    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon

}
}

struct main: Decodable {

    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
    let sea_level: Int?
    let grnd_level: Int?



    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case humidity
        case sea_level
        case grnd_level

}
}
struct wind: Decodable {

    let speed: Double?
    let deg: Int?
    let gust: Double?




    enum CodingKeys: String, CodingKey {
        case speed
        case deg
        case gust

}
}
struct clouds: Decodable {

    let all: Int?


    enum CodingKeys: String, CodingKey {
        case all


}
}
struct sys: Decodable {

    let type: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case country
        case sunrise
        case sunset



}
}
