//
//  Common.swift
//  TestKATA
//
//  Created by Moez bachagha on 9/10/2023.
//

import UIKit
import Alamofire
class Common: NSObject {

    struct Global {
        static let LOCAL = "https://api.openweathermap.org/data/2.5/weather"
        static let Test = "https://api.openweathermap.org/data/2.5/weather?lat=45.764043&lon=4.835659&appid=e1cdd02fb7d3351218063520fae136bc"

        
        static let apiKey = "e1cdd02fb7d3351218063520fae136bc"
        static let headers: HTTPHeaders = [

            "Content-Type": "application/json; charset=utf-8",
            "Access-Control-Allow-Origin" : "*",
            "appid": Common.Global.apiKey


                              ]



      }


}
