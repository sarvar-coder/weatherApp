//
//  Networking .swift
//  Weathery
//
//  Created by Sarvar Boltaboyev on 10/02/25.
//

import Foundation


class FecthingWeatherData {
   static let shared = FecthingWeatherData()
    
    private init() { }
    
    func fetchWeather(byCityName cityName: String, _ handler: @escaping(Result<WeatherData, Error>) -> Void) {
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=96ff321d3f1d5c897e02e33aca560d01"

        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    handler(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { return }
                
                guard let data = data else { return }
                
                do {
                    let result = try JSONDecoder().decode(WeatherData.self, from: data)
                    handler(.success(result))
                } catch {
                    handler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
