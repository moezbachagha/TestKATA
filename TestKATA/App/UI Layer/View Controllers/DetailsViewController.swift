//
//  DetailsViewController.swift
//  TestKATA
//
//  Created by Moez bachagha on 8/10/2023.
//

import UIKit

class DetailsViewController: UIViewController {


    let messages = [
        "Nous téléchargeons les données…",
        "C’est presque fini…",
        "Plus que quelques secondes avant d’avoir le résultat…"
    ]
    var citiesDetails : [City] = []
    private let citiesViewModel: CitiesViewModel = CitiesViewModel()
    var timer: Timer?
    var elapsedTime: TimeInterval = 0
    let totalTime: TimeInterval = 60 // Le temps total en secondes
    let apiCallInterval: TimeInterval = 10 // Intervalle de 10 secondes pour chaque appel API
    var cities = [["Longitude" : -1.6777926,"Latitude" : 48.117266], ["Longitude" :2.3522219,"Latitude" :48.856614], ["Longitude" :-1.553621,"Latitude" :47.218371], ["Longitude" :-0.57918,"Latitude" :44.837789], ["Longitude" :4.835659,"Latitude" :45.764043]]
    var currentCityIndex = 0
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data to Show"
        label.textAlignment = .center
        label.isHidden = true // Initially hidden
        return label
    }()
    var currentIndex = 0


    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var msgTxt: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var restartButton: UIButton!

    @IBAction func restartProgress(_ sender: UIButton) {

        progressBar.setProgress(0, animated: false)
        progressBar.isHidden = false
        restartButton.isHidden = true
        setTimer()
    }


    override func viewDidLoad() {

        super.viewDidLoad()
        citiesTable.addSubview(placeholderLabel)
        placeholderLabel.frame = citiesTable.bounds
        placeholderLabel.isHidden = false
        citiesTable.isHidden = true
        restartButton.isHidden = true
        progressBar.setProgress(0.0, animated: false)
        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true
        showMessage("Nous téléchargeons les données…")

        // Créez un timer qui se déclenche toutes les 6 secondes
        timer =  Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { [self] timer in
            if currentIndex < messages.count {
                let message = messages[currentIndex]
                showMessage(message)
                currentIndex += 1
            } else {
                currentIndex = 0
            }
        }
        setTimer()

    }
    func setTimer(){
        let progressTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressAndFetchWeather), userInfo: nil, repeats: true)
    }




    @objc func updateProgressAndFetchWeather() {
        elapsedTime += 1.0
        let progress = Float(elapsedTime / totalTime)
        progressBar.progress = progress

        if elapsedTime >= totalTime {
            timer?.invalidate()

            DispatchQueue.main.async { [self] in

                showMessage("Téléchargement terminé!")
                placeholderLabel.isHidden = true
                citiesTable.isHidden = false
                restartButton.isHidden = false
                progressBar.isHidden = true
                citiesTable.reloadData()
                if progressBar.progress >= 1.0 {
                    restartButton.isHidden = false
                }
            }

        }

        if elapsedTime.truncatingRemainder(dividingBy: apiCallInterval) == 0 {
            if currentCityIndex < cities.count {
                let city = cities[currentCityIndex]
           

                citiesViewModel.getCityDetails(lon: city["Longitude"]!, lat: city["Latitude"]!, completion : { [weak self] (City, error) in
                    if let error = error {
                        let alert = UIAlertController(title: "Error",
                                                      message: "Could not retrieve schools: \(error.localizedDescription)",
                                                      preferredStyle: .alert)

                        let action = UIAlertAction(title: "OK",
                                                   style: .default)
                        alert.addAction(action)
                        self?.present(alert,
                                      animated: true)
                    }

                    if let City = City {
                        self!.citiesDetails.append(contentsOf: City)
                    }
                })
                currentCityIndex += 1

            }
        }
    }




    func showMessage(_ message: String) {
        msgTxt.text = message
    }



}
extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesDetails.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let content = cell.viewWithTag(0)
        let cityName = content!.viewWithTag(1) as! UILabel
        let cityWeather = content!.viewWithTag(2) as! UILabel
        let weatherDescription = content!.viewWithTag(3) as! UILabel
        let weatherImg = content!.viewWithTag(6) as! UIImageView

        if elapsedTime >= totalTime {

            DispatchQueue.main.async { [self] in

                let city = citiesDetails[indexPath.row]
                cityName.text = city.name
                var celsiusTemperature = (city.main?.feels_like!)! - 273.15
                var intValue = Int(celsiusTemperature)
                cityWeather.text = String(intValue) + "°C"
                weatherDescription.text = city.weather?.first?.description

                switch city.weather?.first?.main {
                case "Clear":
                    weatherImg.image  = UIImage(named: "clear")
                case "Rain":
                    weatherImg.image  = UIImage(named: "rain")
                case "Snow":
                    weatherImg.image  = UIImage(named: "snow")
                case "Clouds":
                    weatherImg.image  = UIImage(named: "clouds")

                default:
                    weatherImg.image  = UIImage(named: "clear")

                }


            }

        }



        return cell
    }
}
