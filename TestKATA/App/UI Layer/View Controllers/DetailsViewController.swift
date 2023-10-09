//
//  DetailsViewController.swift
//  TestKATA
//
//  Created by Moez bachagha on 8/10/2023.
//

import UIKit

class DetailsViewController: UIViewController {

        var timer: Timer?
        var elapsedTime: TimeInterval = 0
        let totalTime: TimeInterval = 60 // Le temps total en secondes
        let apiCallInterval: TimeInterval = 10 // Intervalle de 10 secondes pour chaque appel API
        var cities = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"]
        let messages = [" Nous téléchargeons les données…", " C’est presque fini…", "Plus que quelques secondes avant d’avoir le résultat…"]
        var currentCityIndex = 0

    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var msgTxt: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!



    override func viewDidLoad() {

        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true


        super.viewDidLoad()
         startTimer()
     }

    func startTimer() {
          timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressAndFetchWeather), userInfo: nil, repeats: true)
      }

      @objc func updateProgressAndFetchWeather() {
          elapsedTime += 1.0
          let progress = Float(elapsedTime / totalTime)
          progressBar.progress = progress

          if elapsedTime >= totalTime {

              DispatchQueue.main.async { [self] in
                  timer?.invalidate()
                displayCitiesInTableView()
                  }

          }

          if elapsedTime.truncatingRemainder(dividingBy: apiCallInterval) == 0 {
              if currentCityIndex < cities.count {
                  let city = cities[currentCityIndex]
                  fetchWeatherForCity(city)
                  currentCityIndex += 1
              }
          }
      }

      func fetchWeatherForCity(_ city: String) {
         print(city)
      }

      func displayCitiesInTableView() {

          citiesTable.reloadData()
      }



}
extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return cities.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
                  let content = cell.viewWithTag(0)
                  let cityName = content!.viewWithTag(1) as! UILabel
                  let country = content!.viewWithTag(2) as! UILabel
                  let weatherDescription = content!.viewWithTag(3) as! UILabel

        if elapsedTime >= totalTime {

            DispatchQueue.main.async { [self] in
                let city = cities[indexPath.row]
                cityName.text = city                }

        }



                  return cell
    }
    }
