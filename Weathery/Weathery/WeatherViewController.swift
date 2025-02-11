//
//  ViewController.swift
//  Weathery
//
//  Created by Sarvar Boltaboyev on 08/02/25.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let backgroundView = UIImageView()
    let rootStackView = UIStackView()
    
    // search
    let searchStackView = UIStackView()
    let locationButton = UIButton()
    let searchButton = UIButton()
    let searchTextField = UITextField()
    
    // weather
    let conditonImageView = UIImageView()
    let tempratureLabel = UILabel()
    let cityLabel = UILabel()
    
    // networking
    let fetchWeather = FecthingWeatherData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()

    }
    
    @objc func searchButtonTapped() {
        guard let cityName = searchTextField.text else { return }
        if !cityName.isEmpty {
            fetchBySearchName(cityName: cityName)
        } else {
            showAlert()
        }
    }
    
    @objc func locationButtonTapped() {
        
    }
}

extension WeatherViewController {
    
    func style() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "day-background")
        backgroundView.contentMode = .scaleAspectFill
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
        
        // search
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.north.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        locationButton.isHidden = true
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        searchTextField.becomeFirstResponder()
        searchTextField.textAlignment = .left
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        
        // weather
        conditonImageView.translatesAutoresizingMaskIntoConstraints = false
        conditonImageView.image = UIImage(systemName: "sun.max")
        conditonImageView.tintColor = .label
        
        tempratureLabel.translatesAutoresizingMaskIntoConstraints = false
        tempratureLabel.tintColor = .label
        tempratureLabel.attributedText = makeTemprature(temp: 0)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.tintColor = .label
        cityLabel.font = .systemFont(ofSize: 32)
        cityLabel.text = "---"
    }
    
    func layout() {
        view.addSubview(backgroundView)
        view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(searchStackView)
        rootStackView.addArrangedSubview(conditonImageView)
        rootStackView.addArrangedSubview(tempratureLabel)
        rootStackView.addArrangedSubview(cityLabel)
        
        
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            // backgroundView
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //            rootStackView
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:  1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1),
            
            // searchStackView
            searchStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor),
            
            // locationButton
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            // searchButton
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            // conditionImageView
            conditonImageView.widthAnchor.constraint(equalToConstant: 120),
            conditonImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

// MARK: - Helper Methods
extension WeatherViewController {
    func fetchBySearchName(cityName: String) {
        fetchWeather.fetchWeather(byCityName: cityName) { result in
            switch result {
            case .success(let success):
                print(success.main.temp)
                self.updateLabel(with: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateLabel(with weatherData: WeatherData) {
        tempratureLabel.attributedText = makeTemprature(temp: weatherData.main.temp - 273.15)
        cityLabel.text = weatherData.name
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Please", message: "First type city name which you want to about current weather", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
